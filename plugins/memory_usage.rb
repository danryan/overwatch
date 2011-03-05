name "Memory Usage"
desc "Report on free, used and total memory"

mem_info = {}
`cat /proc/meminfo`.each_line do |line|
  _, key, value = *line.match(/^(\w+):\s+(\d+)\s/)
  mem_info[key] = value.to_i
end

# memory info is empty - operating system may not support it (why doesn't an exception get raised earlier on mac osx?)
# if mem_info.empty?
#   raise "No such file or directory"
# end

mem_total = mem_info['MemTotal'] / 1024
mem_free = (mem_info['MemFree'] + mem_info['Buffers'] + mem_info['Cached']) / 1024
mem_used = mem_total - mem_free
mem_percent_used = (mem_used / mem_total.to_f * 100).to_i

swap_total = mem_info['SwapTotal'] / 1024
swap_free = mem_info['SwapFree'] / 1024
swap_used = swap_total - swap_free
  
swap_percent_used = (swap_used / swap_total.to_f * 100).to_i unless swap_total == 0  

data :memory_total, mem_total
data :memory_used, mem_used
data :memory_percent_used, mem_percent_used
data :swap_total, swap_total
data :swap_used, swap_used
data :swap_percent_used, swap_percent_used

report