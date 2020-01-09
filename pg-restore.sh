#!/bin/bash
PGPASSWORD=sbl6opulogdso6aj pg_restore -U doadmin -h pg-primary-do-user-4175629-0.db.ondigitalocean.com -p 25060 -d defaultdb 