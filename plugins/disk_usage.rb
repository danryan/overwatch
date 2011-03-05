name "Disk Usage"
desc "Report the used and free percentaces of every disk"

DF_RE = /\A\s*(\S.*?)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s*\z/

df_command   = "df -h"
df_output    = `#{df_command}`

def parse_file_systems(io, &line_handler)
  line_handler ||= lambda { |row| pp row }
  headers      =   nil

  row = ""
  io.each_line do |line|
    if headers.nil? and line =~ /\AFilesystem/
      headers = line.split(" ", 6)
    else
      row << line
      if row =~  DF_RE
        fields = $~.captures
        line_handler[headers ? Hash[*headers.zip(fields).flatten] : fields]
        row = ""
      end
    end
  end
end

def clean_value(value)
  if value =~ /G/i
    value.to_f
  elsif value =~ /M/i
    (value.to_f/1024.to_f).round
  elsif value =~ /K/i
    (value.to_f/1024.to_f/1024.to_f).round
  elsif value =~ /T/i
    (value.to_f*1024.to_f).round
  else
    value.to_f
  end
end

df_lines = []
parse_file_systems(df_output) { |row| df_lines << row }


df_line = nil
# if option("filesystem")
#   df_lines.each do |line|
#     if line.has_value?(option("filesystem"))
#       df_line = line
#     end
#   end
# end

# else just use the first line
df_line ||= df_lines.first

# remove 'filesystem' and 'mounted on' if present - these don't change. 
df_line.reject! { |name,value| ['filesystem','mounted on'].include?(name.downcase.gsub(/\n/,'')) }  

# capacity on osx = Use% on Linux ... convert anything that isn't size, used, or avail to capacity ... a big assumption?
assumed_capacity = df_line.find { |name,value| !['size','used','avail'].include?(name.downcase.gsub(/\n/,''))}
df_line.delete(assumed_capacity.first)
df_line['capacity'] = assumed_capacity.last

# will be passed at the end to report to Scout

df_line.each do |name, value|
  data name.downcase.strip.to_sym, clean_value(value)
end

report
