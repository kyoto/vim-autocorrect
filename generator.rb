# Ruby's capitalize doesn't quite do what we want for wifi->Wi-Fi,
# since "Wi-Fi".capitalize => "Wi-fi"
def my_capitalize(s)
  s[0..0].upcase + s[1..-1]
end

# Returns a bool indicating whether lhs is a valid iabbrev LHS
def valid_lhs?(lhs)
  !(lhs =~ /^\w*([[:punct:]]+|[\u0021-\u007e])$/).nil?
end

# Load all mappings. If there are duplicate lhs strings, ignore all but the first.
mappings = {}
Dir.glob("data/*.dat").each do |file|
  File.open(file).each do |line|
    (lhs, rhs) = line.chomp.split("->").map(&:strip) # we don't want the line ending
    mappings[lhs] = rhs unless mappings[lhs] || !valid_lhs?(lhs) || lhs.length < 2
  end
end

output = File.open("autocorrect.vim", "w")
mappings.keys.sort.each do |lhs|
  rhs = mappings[lhs]

  output.puts "ia #{lhs} #{rhs}"

  # if the words are already capitalized or the correction is capitalization, skip
  capitalized = my_capitalize(lhs)
  unless capitalized == lhs || capitalized == rhs
    output.puts "ia #{capitalized} #{my_capitalize(rhs)}"
  end
end

