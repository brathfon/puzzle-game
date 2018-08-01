
-- special case for the root user that will have permissions to do all.  Initial root password will be "default"
-- email will be used as the login
INSERT INTO users (first_name, last_name, initials, email, phone_number, salt, hash) values  -- root_pw #1
   ('Puzzle', 'Admin', '99', 'admin', null,
    '7e58de529f6d552bff5d63f5af98678a',
    '0aaf2ada1d66e2eea03ae076648f9b890e219f21cb5069af3bd19ae98ea9b1e3d46b2be8e5c572a5c09836ce014aa6000ac3161477cdf111ebba443bc0a63c72');

-- Roles information
INSERT INTO roles (abrv, long_name) VALUES ( 'ADM', 'Administration');
INSERT INTO roles (abrv, long_name) VALUES ( 'DE', 'Data Entry');
INSERT INTO roles (abrv, long_name) VALUES ( 'DV', 'Data Verification');
INSERT INTO roles (abrv, long_name) VALUES ( 'QA', 'Quality Assurance');
INSERT INTO roles (abrv, long_name) VALUES ( 'RO', 'Read Only');   -- in case we want to let someone look at the data as entered


INSERT INTO user_roles (user_id, role_id) VALUES ( 1, 1);  -- initial root user who has admin privileges
INSERT INTO user_roles (user_id, role_id) VALUES ( 1, 2);  -- this value is more for testing, giving root DE privs
