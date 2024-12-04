<?php
   use charlesroth_net\Utils\Env;

   use CharlesRothDotNet\Alfred\Str;
   use CharlesRothDotNet\Alfred\SmartyPage;

   require_once('../vendor/autoload.php');

   $env = Env::getEnv();
   $page = getGet('page', "Albums");
   $dir = $env['path'] . $page;

   $breadcrumb = array();
   $prevUri = "";
   foreach (explode("/", $page) as $item) {
      $itemRecord = array("uri" => "index.php?page=$prevUri$item", "label" => Str::substringBefore($item, ".dir"));
      $breadcrumb[] = $itemRecord;
      $prevUri = "$prevUri$item/";
   }

   $order = SCANDIR_SORT_ASCENDING;
   if (str_ends_with($dir, ".rev.dir")) $order = SCANDIR_SORT_DESCENDING;
   $files = scandir($dir, $order);
   $fileDict = array();
   foreach ($files as $file)  addFileEntry($fileDict, $file, $dir);

   $smarty = new SmartyPage();
   $smarty->assign("fileDict", $fileDict);
   $smarty->assign("breadcrumb", $breadcrumb);
   $smarty->assign("page", $page);
   $smarty->assign("dir", $dir);
   $smarty->display("index.tpl");

   function getGet(string $name, $default): string {
      if (empty($name))  return "";
      return isset($_GET[$name])  ? trim($_GET[$name])  : $default;
   }

   function addFileEntry (&$fileDict, string $fileName, string $dir): void {
      if (str_starts_with($fileName, "."))  return;
      if (str_starts_with($fileName, "_"))  return;

      $basename = Str::substringBefore($fileName, ".");
      if (! array_key_exists($basename, $fileDict)) {
         $fileRecord = array("dir" => "", "img" => "", "thu" => "", "txt" => "", "lnk" => "");
         $fileDict[$basename] = $fileRecord;
      }

      $fileRecord = &$fileDict[$basename];
      if     (str_ends_with($fileName, ".dir"))   $fileRecord['dir'] = $fileName;
      elseif (str_ends_with($fileName, ".lnk"))   $fileRecord['lnk'] = file_get_contents("$dir/$fileName", false);
      elseif (str_contains ($fileName, ".img."))  $fileRecord['img'] = $fileName;
      elseif (str_contains ($fileName, ".thu."))  $fileRecord['thu'] = $fileName;
      elseif (str_contains ($fileName, ".txt."))  $fileRecord['txt'] = $fileName; // should be contents of file!
   }
