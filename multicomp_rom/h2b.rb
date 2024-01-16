count = 0
File.open("BASIC.BIN", "wb") do |out|
  File.read("BASIC.HEX").split(/\r\n/).each_with_index do |line, idx|
    # l = line[9..-3]
    # puts "#{idx} - #{l.length} - #{l}"
    # break

    # # todo: break l into 2 char chunks, these are hex digits.
    # #       for each hex pair, write out bin byte.
    # #       should have 8k when done.
    #lengths.push(line.length)
    if line =~ /\:(..)(....)(..)(.*)(..)/
      puts "#{$1} #{$2} #{$3} #{$4} #{$5} #{$6}"
      byteCount = $1.to_i(16)
      address = $2
      recordType = $3
      data = $4
      chkSum = $5

      if recordType == "00"
        (0...byteCount).each do |i|
          idx = i*2
          hex = data[idx..idx+1]
          out.putc(hex.to_i(16).chr)
          count += 1
        end
        #puts "data length: #{data.length}"
      end
    end
  end
end

puts "#{count} bytes written."