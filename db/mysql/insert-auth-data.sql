
-- special case for the root user that will have permissions to do all.  Initial root password will be "default"
-- email will be used as the login
INSERT INTO users (first_name, last_name, initials, email, phone_number, salt, hash) values  -- root_pw #1
   ('Puzzle', 'Admin', '99', 'pzadmin', null,
    '95a0fc6076fad1a8a1714f5715c1abf1',
    '08442ffd0b4fb92b00d92725bc61ff93ffc78b5e3db9506e9db1c08e78f8e26b447e4237206ce34b55aa3775293d1400f4caf59077e36b11cefdecd7efe08f5f');

-- Roles information
INSERT INTO roles (abrv, long_name) VALUES ( 'ADM', 'Administration');
INSERT INTO roles (abrv, long_name) VALUES ( 'DE', 'Data Entry');
INSERT INTO roles (abrv, long_name) VALUES ( 'DV', 'Data Verification');
INSERT INTO roles (abrv, long_name) VALUES ( 'QA', 'Quality Assurance');
INSERT INTO roles (abrv, long_name) VALUES ( 'RO', 'Read Only');   -- in case we want to let someone look at the data as entered


INSERT INTO user_roles (user_id, role_id) VALUES ( 1, 1);  -- initial root user who has admin privileges
INSERT INTO user_roles (user_id, role_id) VALUES ( 1, 2);  -- this value is more for testing, giving root DE privs
