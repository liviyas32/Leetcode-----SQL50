select user_id, name, mail
from users
where mail regexp '^[a-zA-Z][a-zAZ0-9_.-]*@leetcode[.]com';
