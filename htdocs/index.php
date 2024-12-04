<?php
   use CharlesRothDotNet\Alfred\Str;
   use CharlesRothDotNet\Alfred\SmartyPage;
   use CharlesRothDotNet\Alfred\HttpGet;
   use CharlesRothDotNet\Alfred\EnvFile;

   require_once('../vendor/autoload.php');

   $page = HttpGet::value('page', "Albums");
   $env  = new EnvFile(".env");
   $dir  = $env->get('path') . $page;

   $breadcrumbs = makeBreadCrumbArrayFrom($page);

   $order = (Str::endsWith($dir, ".rev.dir") ? SCANDIR_SORT_DESCENDING : SCANDIR_SORT_ASCENDING);
   $files = scandir($dir, $order);
   $fileDict = array();
   foreach ($files as $file)  addFileEntry($fileDict, $file, $dir);

   $smarty = new SmartyPage();
   $smarty->assign("fileDict", $fileDict);
   $smarty->assign("breadcrumb", $breadcrumbs);
   $smarty->assign("page", $page);
   $smarty->assign("dir", $dir);
   $smarty->display("index.tpl");

   function makeBreadCrumbArrayFrom(string $page): array {
      $breadcrumbs = array();
      $prevUri = "";
      foreach (explode("/", $page) as $item) {
         $itemRecord = array("uri" => "index.php?page=$prevUri$item", "label" => Str::substringBefore($item, ".dir"));
         $breadcrumbs[] = $itemRecord;
         $prevUri = "$prevUri$item/";
      }
      return $breadcrumbs;
   }

   function addFileEntry (&$fileDict, string $fileName, string $dir): void {
      if (Str::startsWith($fileName, "."))  return;
      if (Str::startsWith($fileName, "_"))  return;

      $basename = Str::substringBefore($fileName, ".");
      if (! array_key_exists($basename, $fileDict)) {
         $fileRecord = array("dir" => "", "img" => "", "thu" => "", "txt" => "", "lnk" => "");
         $fileDict[$basename] = $fileRecord;
      }

      $fileRecord = &$fileDict[$basename];
      if     (Str::endsWith($fileName, ".dir"))    $fileRecord['dir'] = $fileName;
      elseif (Str::endsWith($fileName, ".lnk"))    $fileRecord['lnk'] = file_get_contents("$dir/$fileName", false);
      elseif (Str::contains ($fileName, ".img."))  $fileRecord['img'] = $fileName;
      elseif (Str::contains ($fileName, ".thu."))  $fileRecord['thu'] = $fileName;
      elseif (Str::contains ($fileName, ".txt."))  $fileRecord['txt'] = $fileName; // should be contents of file!
   }
