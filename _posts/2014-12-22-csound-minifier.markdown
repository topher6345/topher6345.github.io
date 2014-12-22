---
---

# Csound minifier

usage 

`cat trapped.csd | ruby csound.rb > trapped.min.csd && csound trapped.min.csd`

```ruby
require 'nokogiri'

# Add behvaior to string class.
class String
  def minify
    # get array of lines
    lines.delete_if { |l| l == "\n" }.join('') # remove empty lines
      .gsub(/;.+/, '') # remove comments
      .gsub(/\s+$/, '') # remove trailing whitespace
  end
end

# Get everything between <CsoundSynthesizer> tags
csd = Nokogiri::XML(STDIN.read).xpath('//CsoundSynthesizer')

# Call minify on each section
score = csd.xpath('//CsScore').to_s.minify
options = csd.xpath('//CsOptions').to_s.minify
orc = csd.xpath('//CsInstruments').to_s.minify

# Print to STDOUT
puts '<CsoundSynthesizer>'
puts options, orc, score
puts '</CsoundSynthesizer>'
```
