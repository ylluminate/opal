h = {}

10_000.times do |i|
  h[i.to_s] = i
end

1_000.times do |i|
  k, v = h.rassoc(i)
end
