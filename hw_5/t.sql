SELECT * FROM information_schema.column_privileges WHERE table_name = 'orders' AND grantee = 'trainee' ORDER BY column_name, privilege_type;
