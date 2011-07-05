$(document).ready(function() {

  var charts = [];
  var dp = function(dateStr) {
      var pattern = /^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})-(\d{2}):(\d{2})$/;
      var match = pattern.exec(dateStr);
      if (!match) {throw new Error('::Error, #dp could not parse dateStr '+dateStr);}
      // we're safe to use the fields
      if(match[7] == undefined){ date[7]=0;}
      return Date.UTC(match[1], parseInt(match[2])-1, match[3], match[4], match[5], match[6], match[7]);
  }

  var hourlyStart = $('#chart-container').attr('data-hourly-start');
  var dailyStart = $('#chart-container').attr('data-daily-start');
  var weeklyStart = $('#chart-container').attr('data-weekly-start');
  var monthlyStart = $('#chart-container').attr('data-monthly-start');

  var endAt = $('#chart-container').attr('data-end');


  var parseDates = function(data) {
    $.each(data.data, function(i, obj) {
      $.each(obj, function(key, val) {
        if (val.constructor == String) {
          obj[key] = dp(val);
        }
      })
    })
  }
  
  var chartConfig = function(renderId, title, data) {
    var config = {
      chart: {
        renderTo: renderId,
        width: 500,
        height: 300,
        defaultSeriesType: 'line',
        animation: false
      },
      title: {
        text: title
      },
      subtitle: {
        text: ''
      },
      xAxis: {
        type: 'datetime'
        // tickInterval: 60 * 1000
      },
      yAxis: {
        title: {
          text: ""
        }
      },
      tooltip: {
        enabled: true,
        formatter: function() {
          return '<b>'+ this.series.name +'</b><br/>'+
          new Date(this.x) +': '+ this.y;
        },
        crosshairs: true
      },
      plotOptions: {
        line: {
          dataLabels: {
            enabled: true
          },
          animation: false,
          enableMouseTracking: true,
          lineWidth: 1,
          shadow: false,
          dataLabels: false, 
          states: {
            hover: {
              lineWidth: 1
            }
          },
          marker: {
            enabled: false,
            states: {
              hover: {
                enabled: true,
                radius: 3
              }
            }
          }
        }
      },
      series: []
    }
    
    config.series.push(data);
    return config;
  };
  
  var makeChart = function(title, startAt, endAt, interval, attribute) {
    $.ajax({
      dataType: 'json',
      url: '/assets/1/attributes.json?attr=' + attribute + '&date=true&start_at=' + startAt + "&end_at=" + endAt + "&interval=" + interval,
      success: function(data){
        parseDates(data);
        $('#chart-container').append('<div class="graph" id="chart-' + title + '"></div>');
        var chart = new Highcharts.Chart(
          chartConfig("chart-" + title, title, data)
        );
        
      }
    })
  }
  
  makeChart("hourly", hourlyStart, endAt, 'minute', "one")
  makeChart("daily", dailyStart, endAt, 'quarter', "one")
  // makeChart("weekly", weeklyStart, endAt, 'hour', "one")
  // makeChart("monthly", monthlyStart, endAt, 'day', "one")
  
});