<?php

$config['default_host'] = 'ssl://mail.saoirse.home.arpa';
$config['imap_host'] = 'ssl://mail.saoirse.home.arpa';

$config['imap_conn_options'] = array(
  'ssl' => array(
    'verify_peer'  => true,
    'verify_depth' => 3,
    'cafile'       => '/var/roundcube/ca.crt',
  ),
);

$config['log_logins'] = false;
$config['log_session'] = false;
$config['log_authfail'] = false;
$config['smtp_log'] = false;
$config['imap_log'] = false;
$config['disabled_actions'] = ['mail.delete', 'mail.expunge', 'mail.purge', 'addressbook'];
