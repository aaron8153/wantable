$(function() {

    var start = moment().subtract(10, 'years');
    var end = moment();

    function cb(start, end) {
        $('#daterange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    }

    $('#daterange').daterangepicker({
        startDate: start,
        endDate: end,
        ranges: {
            'All Time': [moment().subtract(10, 'years'), moment()],
            'Today': [moment(), moment()],
            'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            'Last 7 Days': [moment().subtract(6, 'days'), moment()],
            'Last 30 Days': [moment().subtract(29, 'days'), moment()],
            'This Month': [moment().startOf('month'), moment().endOf('month')],
            'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
    }, cb);

    cb(start, end);

    $('#daterange').on('apply.daterangepicker', function(ev, picker) {
        st_d = picker.startDate.unix();
        end_d = picker.endDate.unix();
        $.ajax({
            url: '/reports/product_sales',
            method: 'post',
            data: {
                start_date: st_d,
                end_date: end_d
            }
        }).done(function ( data ) {
            $('#product-results').html(data);
        });
    });

});