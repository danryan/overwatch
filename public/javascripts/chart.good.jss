$(document).ready(function() {

  var charts = [];
  function dp(dateStr) {
      var pattern = /^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})-(\d{2}):(\d{2})$/;
      var match = pattern.exec(dateStr);
      if (!match) {throw new Error('::Error, #dp could not parse dateStr '+dateStr);}
      // we're safe to use the fields
      if(match[7] == undefined){ date[7]=0;}
      return Date.UTC(match[1], parseInt(match[2])-1, match[3], match[4], match[5], match[6], match[7]);
  }

  // var defaults = {
  //   chart: {
  //     width: 500,
  //     height: 300,
  //     defaultSeriesType: 'line',
  //     animation: false,
  //     renderTo: 'chart-hourly'
  //   },
  //   title: {
  //     text: ''
  //   },
  //   subtitle: {
  //     text: ''
  //   },
  //   xAxis: {
  //     type: 'datetime',
  //   },
  //   yAxis: {
  //     title: {
  //       text: "Metric"
  //     }
  //   },
  //   tooltip: {
  //     enabled: true,
  //     formatter: function() {
  //       return '<b>'+ this.series.name +'</b><br/>'+
  //       this.x +': '+ this.y;
  //     }
  //   },
  //   plotOptions: {
  //     line: {
  //       dataLabels: {
  //         enabled: true
  //       },
  //       animation: false,
  //       enableMouseTracking: false
  //     }
  //   }
  // }
  
  
  // var hourlyOptions = defaults;
  // var dailyOptions = defaults;
  // var weeklyOptions = defaults;
  // var monthlyOptions = defaults;
  //   
  //   hourlyOptions.chart.renderTo = 'chart-hourly';
  //   dailyOptions.chart.renderTo = 'chart-daily';
  //   weeklyOptions.chart.renderTo = 'chart-weekly';
  //   monthlyOptions.chart.renderTo = 'chart-monthly';
  // 
  //   var hourlyChart = new Highcharts.Chart(hourlyOptions);
  //   var dailyChart = new Highcharts.Chart(dailyOptions);
  //   var weeklyChart = new Highcharts.Chart(weeklyOptions);
  //   var monthlyChart = new Highcharts.Chart(monthlyOptions);

  var hourlyStart = $('#chart-hourly').attr('data-start');
  var dailyStart = $('#chart-daily').attr('data-start');
  var weeklyStart = $('#chart-weekly').attr('data-start');
  var monthlyStart = $('#chart-monthly').attr('data-start');

  var endAt = $('#chart-hourly').attr('data-end');


  var parseDates = function(data) {
    $.each(data.data, function(i, obj) {
      $.each(obj, function(key, val) {
        if (val.constructor == String) {
          obj[key] = dp(val);
        }
      })
    })
  }
    
  // $.ajax({
  //   dataType: 'json',
  //   url: '/assets/5/attributes.json?attr=one&date=true&start_at=' + hourlyStart + "&end_at=" + endAt,
  //   success: function(data){
  //     parseDates(data);
  //     hourlyChart.addSeries({
  //       name: data.name,
  //       data: data.data
  //     });
  //   }
  // });
  //  
  // $.ajax({
  //   dataType: 'json',
  //   url: '/assets/5/attributes.json?attr=one&date=true&start_at=' + dailyStart + "&end_at=" + endAt,
  //   success: function(data){
  //     parseDates(data);
  //     dailyChart.addSeries({
  //       name: data.name,
  //       data: data.data
  //     });
  //   }
  // });
  // 
  // $.ajax({
  //   dataType: 'json',
  //   url: '/assets/5/attributes.json?attr=one&date=true&start_at=' + weeklyStart + "&end_at=" + endAt,
  //   success: function(data){
  //     parseDates(data);
  //     weeklyChart.addSeries({
  //       name: data.name,
  //       data: data.data
  //     });
  //   }
  // });
  // 
  // $.ajax({
  //   dataType: 'json',
  //   url: '/assets/5/attributes.json?attr=one&date=true&start_at=' + monthlyStart + "&end_at=" + endAt,
  //   success: function(data){
  //     parseDates(data);
  //     monthlyChart.addSeries({
  //       name: data.name,
  //       data: data.data
  //     });
  //   }
  // });
  
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
        type: 'datetime',
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
          this.x +': '+ this.y;
        }
      },
      plotOptions: {
        line: {
          dataLabels: {
            enabled: true
          },
          animation: false,
          enableMouseTracking: false
        }
      },
      series: []
    }
    
    config.series.push(data);
    console.log(config);
  };
  
  $.ajax({
    dataType: 'json',
    url: '/assets/5/attributes.json?attr=one&date=true&start_at=' + hourlyStart + "&end_at=" + endAt,
    success: function(data){
      parseDates(data);
      new Highcharts.Chart(chartConfig("chart-hourly", "Hourly", data))
    }
  });
  
});