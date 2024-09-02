document.addEventListener('DOMContentLoaded', () => {
    const ctx = document.getElementById('myChart').getContext('2d');
    let myChart = null;

    const chartTypeSelect = document.getElementById('chartType');
    const dataFileSelect = document.getElementById('dataFile');

    const apiEndpoints = {
        'data1.json': 'https://localhost:7157/api/BookStore',
        'data2.json': 'https://localhost:7157/api/CarSales',
        'data3.json': 'https://localhost:7157/api/MovieStore'
    };

    const loadData = async (url) => {
        try {
            const response = await fetch(url);
            const data = await response.json();
            return data;
        } catch (error) {
            console.error('Veri yüklenirken bir hata oluştu:', error);
            return null;
        }
    };

    const updateChart = async () => {
        const chartType = chartTypeSelect.value;
        const selectedDataFile = dataFileSelect.value;
        const apiUrl = apiEndpoints[selectedDataFile];

        const data = await loadData(apiUrl);

        if (data === null) return;

        const labels = [];
        const values = [];

        if (data.length > 0) {
            if (data[0].author) {
                data.forEach(item => {
                    labels.push(item.author || item.brand || item.director);
                    values.push(item.totalSales || item.totalViews);
                });
            } else {
                data.forEach(item => {
                    labels.push(item.brand || item.director || 'Unknown');
                    values.push(item.totalSales || item.totalViews);
                });
            }
        }

        if (myChart) {
            myChart.destroy();
        }

        myChart = new Chart(ctx, {
            type: chartType,
            data: {
                labels: labels,
                datasets: [{
                    label: 'Veri',
                    data: values,
                    backgroundColor: generateColors(labels.length),
                    borderColor: generateColors(labels.length),
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.label + ': ' + context.raw;
                            }
                        }
                    }
                }
            }
        });
    };

    const generateColors = (count) => {
        const colors = [];
        for (let i = 0; i < count; i++) {
            colors.push(`hsl(${Math.random() * 360}, 100%, 75%)`);
        }
        return colors;
    };

    chartTypeSelect.addEventListener('change', updateChart);
    dataFileSelect.addEventListener('change', updateChart);

    updateChart(); // İlk yükleme
});
