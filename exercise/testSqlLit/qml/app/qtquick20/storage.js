// storage.js

/*!
 * Connect to cmosvideoplayer db, if not exist, will create one.
 */
function getDatabase() {
    return LocalStorage.openDatabaseSync("cmosvideoplayer", "1.0", "VideoPlayerDatabase", 0/*100000*/);
}

/*!
 * When start videoplayer, should call the initialize().
 */
function initialize() {
    var db = getDatabase();
    db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS videos (
                   "pathid INT, path TEXT, mtime INT")');
                });
}

/*
 *
 */
function setSetting(setting, value) {
    var db = getDatabase();
    var res = "";
    db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
        //console.log(rs.rowsAffected)
        if (rs.rowsAffected > 0) {
            res = "OK";
        } else {
            res = "Error";
        }
    }
    );
    return res;
}

// 获取数据
function getSetting(setting) {
    var db = getDatabase();
    var res="";
    db.transaction(function(tx) {
        var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
        if (rs.rows.length > 0) {
            res = rs.rows.item(0).value;
        } else {
            res = "Unknown";
        }
    })
    return res
}
