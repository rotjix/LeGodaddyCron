<?php
// script.php [path to cert.pem] [path to privkey.pem]

include "cpanel/cpaneluapi.class.php";

$uapi = new cpanelAPI(getenv("CPANEL_USER"), getenv("CPANEL_PASS"), getenv("CPANEL_HOST"));
$domain = getenv("DOMAINS");

$crt = file_get_contents($argv[1]);
$key = file_get_contents($argv[2]);

echo "\nCERT ---\n";
var_dump($crt);
echo "\nKEY  ---\n";
var_dump($key);
echo "\nEND  ---\n";

$domainlist = explode(" ", $domain);

foreach ($domainlist as &$value) {
    var_dump($uapi->uapi->post->SSL->install_ssl(["domain" => $value, "cert" => $crt, "key" => $key]));
}
