name "Load Average"
desc "Report the one, five and fifteen minute load averages"

regex = Regexp.new(/load averages?: ([\d.]+),? ([\d.]+),? ([\d.]+)\Z/)
averages = regex.match(%x[ uptime ]).captures

data :one_minute, averages[0]
data :five_minutes, averages[1]
data :fifteen_minutes, averages[1]

report