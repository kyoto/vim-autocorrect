# Ruby's capitalize doesn't quite do what we want for wifi->Wi-Fi,
# since "Wi-Fi".capitalize => "Wi-fi"
def my_capitalize(s)
  s[0..0].upcase + s[1..-1]
end

# Load all mappings. If there are duplicate lhs strings, ignore all but the first.
mappings = {}
File.open("autocorrect.dat").each do |line|
  (lhs, rhs) = line.chomp.split("->").map(&:strip) # we don't want the line ending
  mappings[lhs] = rhs unless mappings[lhs]
end

output = File.open("autocorrect.vim", "w")
mappings.each do |lhs, rhs|
  output.puts "ia #{lhs} #{rhs}"

  # if the words are already capitalized or the correction is capitalization, skip
  capitalized = my_capitalize(lhs)
  unless capitalized == lhs || capitalized == rhs
    output.puts "ia #{capitalized} #{my_capitalize(rhs)}"
  end
end

