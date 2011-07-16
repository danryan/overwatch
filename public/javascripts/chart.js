$(document).ready(function() {

  // var charts = [];
  // 
  //   var hourlyStart = $('#chart-container').attr('data-hourly-start');
  //   var dailyStart = $('#chart-container').attr('data-daily-start');
  //   var weeklyStart = $('#chart-container').attr('data-weekly-start');
  //   var monthlyStart = $('#chart-container').attr('data-monthly-start');
  //   var assetId = $('#chart-container').attr('data-asset-id');
  //   var endAt = $('#chart-container').attr('data-end');
  //   
  //   var chartConfig = function(renderId, title) { //, data) {
  //     var config = {
  //       chart: {
  //         renderTo: renderId,
  //         zoomType: 'x',
  //         // width: 500,
  //         height: 300,
  //         defaultSeriesType: 'line',
  //         animation: false
  //       },
  //       title: {
  //         text: title
  //       },
  //       subtitle: {
  //         text: ''
  //       },
  //       xAxis: {
  //         type: 'datetime'
  //         // tickInterval: 60 * 1000
  //       },
  //       yAxis: {
  //         title: {
  //           text: ""
  //         }
  //       },
  //       tooltip: {
  //         enabled: true,
  //         formatter: function() {
  //           d = new Date(this.x);
  //           return '<b>'+ this.series.name +'</b><br/>'+ d.getHours() + ':' + 
  //           d.getMinutes() + ' ' + d.getDate() + '/' + d.getMonth() + '/' +
  //           d.getFullYear() +': '+ this.y;
  //         },
  //         crosshairs: true
  //       },
  //       plotOptions: {
  //         line: {
  //           dataLabels: {
  //             enabled: true
  //           },
  //           animation: false,
  //           enableMouseTracking: true,
  //           lineWidth: 1,
  //           shadow: false,
  //           dataLabels: false, 
  //           states: {
  //             hover: {
  //               lineWidth: 1
  //             }
  //           },
  //           marker: {
  //             enabled: true,
  //             radius: 1,
  //             states: {
  //               hover: {
  //                 enabled: true,
  //                 radius: 3
  //               }
  //             }
  //           }
  //         }
  //       },
  //       series: []
  //     }
  //     
  //     // config.series.push(data);
  //     return config;
  //   };
  //   
  //   var getChartDetails = function(attribute, func, startAt, endAt) {
  //     $.ajax({
  //       dataType: 'json',
  //       url: '/assets/' + assetId + '/attributes.json?attr=' + attribute + '&function=' + func + '&start_at=' + startAt + "&end_at=" + endAt,
  //       success: function(data){
  //         $('#chart-' + func).text(func + ': ' + data);
  //       }
  //     })    
  //   }
  //     
  //   var makeChart = function(title, startAt, endAt, interval, attribute) {
  //     $.ajax({
  //       dataType: 'json',
  //       url: '/assets/' + assetId + '/attributes.json?attr=' + attribute + '&date=true&start_at=' + startAt + "&end_at=" + endAt + "&interval=" + interval,
  //       success: function(data){
  //         // parseDates(data);
  //         $('#chart-container').append('<div class="graph" id="chart-' + title + '"></div>');
  //         var chart = new Highcharts.Chart(
  //           chartConfig("chart-" + title, title) //, data)
  //         );
  //         chart.addSeries(data);
  //         getChartDetails(attribute, 'first', startAt, endAt);
  //         getChartDetails(attribute, 'last', startAt, endAt);
  //         getChartDetails(attribute, 'median', startAt, endAt);
  //         getChartDetails(attribute, 'min', startAt, endAt);
  //         getChartDetails(attribute, 'max', startAt, endAt);
  //         getChartDetails(attribute, 'average', startAt, endAt);
  //       }
  //     })
  //     
  //   }
  //   
  //   $("select#asset_top_level_attributes").change(function(){
  //     $("#attribute_keys").show('slow');
  //     var value = this.value;
  //     $.ajax({
  //       dataType: 'json',
  //       url: '/assets/' + assetId + '/sub_attributes/' + value,
  //       success: function(data) {
  //         console.log(data);
  //         _.each(data, function(attr) {
  //           $('#attribute_keys').append('<div>' + 
  //           '<input class="check_boxes asset_attribute_key" id="asset_attribute_keys_' +
  //           attr + '" type="checkbox" value="' + attr + 
  //           '"><label class="collection_check_boxes" for="asset_attribute_keys_' + 
  //           attr + '">' + attr + '</label></div>');
  //           makeChart("hourly", hourlyStart, endAt, 'hour', attr);
  //           // alert(box)
  //         })
  //       }
  //     })
  //   });
  //   
  //   
  //   $("input.asset_attribute_key").change(function() {
  //     makeChart("hourly", hourlyStart, endAt, 'hour', this.value);
  //   });
  //   
  
});