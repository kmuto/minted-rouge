#!/usr/bin/env ruby
# demi-compatible pygmentize command
# Copyright 2023 Kenshi Muto
require 'optparse'
require 'open3'
require 'rouge'

class MintedRouge
  def initialize
    @style = nil
    @prefix = nil  # ignored
    @lexer = nil
    @filter = nil  # ignored
    @output = nil
  end

  def parse_opts
    opts = OptionParser.new

    opts.on('-S style') { |style| @style = style }
    opts.on('-f format') { |format| nil }
    opts.on('-P prefix') { |prefix| @prefix = prefix }
    opts.on('-l lexer') { |lexer| @lexer = lexer }
    opts.on('-F filter') { |filter| @filter = filter }
    opts.on('-o output') { |output| @output = output }
    opts.parse!
  end

  def export_style
    style = @style == 'default' ? 'base16' : @style
    theme = Rouge::Theme::find(style)
    unless theme
      STDERR.puts "Rouge style '#{style}' is not defined"
      exit 1
    end
    Rouge::TexThemeRenderer.new(theme.new, prefix: 'PYG').render do |s|
      puts (
        s.gsub(/\{HTML\}\{(......)\}/) do
          if ENV['MINTED_ROUGE_COLOR']
            modify_color($1)
          else
            $&
          end
        end
      )
    end
  end

  def modify_color(html)
    r, g, b = html.scan(/.{2}/).map {|m| m.to_i(16) / 255.to_f }
    c = m = y = k = 0
    k = (1 - [r, g, b].max).round(3)

    if ENV['MINTED_ROUGE_COLOR'] == 'cmyk'
      c = ((1 - r - k) / (1 - k)).round(3)
      m = ((1 - g - k) / (1 - k)).round(3)
      y = ((1 - b - k) / (1 - k)).round(3)

      c = 0 if c <= 0
      m = 0 if m <= 0
      y = 0 if y <= 0
    else
      # BW
      if r != 1 && g != 1 && b != 1
        k = 1
      end
    end
    return "{cmyk}{#{c},#{m},#{y},#{k}}"
  end

  def highlight(stream)
    lexer = Rouge::Lexer.find(@lexer) || Rouge::Lexer.find('text')
    c = ARGF.read
    File.write(@output, Rouge::Formatters::Tex.new(prefix: 'PYG').format(lexer.lex(c)))
  end

  def main
    parse_opts

    if @style
      export_style
    elsif @output
      highlight(ARGF)
    end
  end
end

MintedRouge.new.main
