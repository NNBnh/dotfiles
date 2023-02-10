# frozen_string_literal: true

require 'io/console'
require 'paint'
require 'terminal/join/extensions'

art = <<~ANSI
   ┌───┐
   │[94m▐█▌[0m│
   │[0;1m+ [91m⠔[0m│
   └───'
  [1;94mGameBtw[0m
ANSI

info = {
  shell:       { color: :red,     icon: '', value: 'Ruby'           },
  workspace:   { color: :magenta, icon: '', value: 'Zellij'         },
  distro:      { color: :blue,    icon: '', value: 'Nobara'         },
  font:        { color: :green,   icon: '', value: 'JetBrains Mono' },
  colorscheme: { color: :yellow,  icon: '', value: 'Catppuccin'     }
}
.map do
  Paint["#{_1.to_s.upcase.rjust(16)} #{_2[:icon]}", :bright, _2[:color]] + "  #{_2[:value]}"
end
.join("\n")

color = [
  %i[bright magenta],
  %i[bright blue],
  %i[bright cyan],
  %i[bright green],
  %i[bright yellow],
  %i[       yellow],
  %i[bright red]
]
.map { Paint['  ', *_1] }.join

puts [art, [info, color].vjoin("\n")].hjoin.style(width: IO.console.winsize[1])
