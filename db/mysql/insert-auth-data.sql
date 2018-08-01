
-- special case for the root user that will have permissions to do all.  Initial root password will be "default"
-- email will be used as the login
INSERT INTO users (first_name, last_name, initials, email, phone_number, salt, hash) values  -- root_pw #1
   ('Puzzle', 'Admin', '99', 'admin', null,
    '6eae0dbfd1fcca875fc388be782e7ed2',
    'fa78abb6bbaf650e18b748cdd40ac217eb4d91185c2b1409f13ffb8ebb1fb982e107ff2f1f66f3ba062406f0dd14ca2fcfe43b3335c73155247723411998397a');

-- Roles information
INSERT INTO roles (abrv, long_name) VALUES ( 'ADM', 'Administration');
INSERT INTO roles (abrv, long_name) VALUES ( 'DE', 'Data Entry');
INSERT INTO roles (abrv, long_name) VALUES ( 'DV', 'Data Verification');
INSERT INTO roles (abrv, long_name) VALUES ( 'QA', 'Quality Assurance');
INSERT INTO roles (abrv, long_name) VALUES ( 'RO', 'Read Only');   -- in case we want to let someone look at the data as entered


INSERT INTO user_roles (user_id, role_id) VALUES ( 1, 1);  -- initial root user who has admin privileges
INSERT INTO user_roles (user_id, role_id) VALUES ( 1, 2);  -- this value is more for testing, giving root DE privs
