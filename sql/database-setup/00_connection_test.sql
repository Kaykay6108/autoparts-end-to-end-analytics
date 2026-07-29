SELECT
    @@SERVERNAME AS ServerName,
    DB_NAME() AS CurrentDatabase,
    SYSTEM_USER AS LoginName,
    GETDATE() AS TestTimestamp;
