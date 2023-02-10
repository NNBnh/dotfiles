# frozen_string_literal: true

require 'unicode_plot'

x = 0.step(3 * Math::PI, by: 3 * Math::PI / 30)

UnicodePlot.lineplot(
  x,
  x.map { Math.sin _1 },
  name: 'sin(x)',
  width: 48, height: 8
) => plot

UnicodePlot.lineplot!(
  plot,
  x,
  x.map { Math.cos _1 },
  name: 'cos(x)'
)

plot.render.display
