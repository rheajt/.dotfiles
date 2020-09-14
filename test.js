function importCSVFromGoogleDrive() {
    var file = DriveApp.getFilesByName('data.csv').next();
    const dataString = file
        .getBlob()
        .getDataAsString()
        .split(',')
        .map((each) => {
            console.log(each);
            if (each !== '') {
                return each.replace(/\n/g, '').replace(/\r/g, '');
            } else {
                return each;
            }
        })
        .join(',');

    var csvData = Utilities.parseCsv(dataString);

    var parsedCsvData = csvData.map((row) => {
        return row.map((cell) => {
            const newCell = cell.replace(/\n/g, '').replace(/\r/g, '');
            Logger.log(newCell);
            return newCell;
        });
    });

    var sheet = SpreadsheetApp.getActiveSheet();
    sheet
        .getRange(1, 1, parsedCsvData.length, parsedCsvData[0].length)
        .setValues(parsedCsvData);
}
