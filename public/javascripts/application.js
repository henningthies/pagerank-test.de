(function($, window, undefined){
  $(document).ready(function(){
		$('#domain_url').focus(function() {
			$(this).val('');
		});
		$('#domain_url').blur(function() {
			if($(this).val() === '') {
				$(this).val("deine-domain.de");	
			}
		});


	if($('#chart').length > 0){
		var data = [];
		var categories = [];
		$.each($('.data_date'),function(){
			categories.push(""+this.innerHTML+"")
		});
		
		$.each($('.data_rank'),function(){
			data.push("'"+this.innerHTML+"'")
		});
		var chart1 = new Highcharts.Chart({
    	chart: {
      	renderTo: 'chart-container',
        defaultSeriesType: 'line',
				height: '150',
				width: '400',
				margin: [20,0,20,40]
      },
      title: {
      	text: null
      },
      xAxis: {
				title: {
					text: null
				},
				categories: categories,
				maxPadding: 0.02,
				minPadding: 0.02
      },
      yAxis: {
      	title: {
        	text: null
        },				
				max: 10,
				min: 0,
				maxPadding: 0.02,
				minPadding: 0.02
      },
			legend: {
				enabled: false
			},
      series: [{
        	data: data
      }],	
			tooltip: {
				formatter: function() {
					return this.y
				}
			},
			credits:{
				enabled: false
			}
		});
	}
  });
})(jQuery, window);