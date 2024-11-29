<?php
   namespace charlesroth_net\Utils;

   use Smarty\Smarty;

   class SmartyPage extends Smarty {
      function __construct() {
         parent::__construct();

         $this->setTemplateDir('../templates/');
         $this->setCompileDir ('../templates_c/');
         $this->setConfigDir  ('../configs/');
         $this->setCacheDir   ('../cache/');

         $this->caching = Smarty::CACHING_LIFETIME_CURRENT;
//       $this->debugging = true;
       }
   }
