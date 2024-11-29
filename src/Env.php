<?php
   namespace charlesroth_net\Utils;

   class Env {

      public static function getEnv()  {
         $dict = array();
   
         $dir = str_replace("\\", "/", getcwd());
   
         while (true) {
            $envFile = $dir . "/.env";
            if (file_exists($envFile)) {
               $fp = fopen($envFile, "r");
               while ( ($line = fgets($fp, 4096)) !== false) {
                  if (str_contains($line, "=")) {
                     $parts = explode("=", trim($line), 2);
                     $dict[$parts[0]] = $parts[1];
                  }
               }
               fclose ($fp);
               return $dict;
            }
   
            $lastSlash = strrpos($dir, "/");
            if ($lastSlash === false)  return $dict;
            $dir = substr($dir, 0, $lastSlash);
         }
      }
   }
