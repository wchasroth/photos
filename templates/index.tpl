{nocache}
<html>
<head>
   <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto">
   <style type="text/css">
      body, td, div { font-family: 'Roboto', sans-serif; }
   </style>
</head>
<body style="margin-top: 0;  padding-top: 0;">

<!-- So that images can scroll "under", leaving the breadcrumb trail always visible at the top. -->
<div style="position: fixed; z-index: 1; background-color: white; width: 100%;  padding-top: 1em;">
   {assign var="separator" value=""}
   &nbsp;&nbsp;
   {foreach $breadcrumb as $crumb}
      {$separator}
      {if $crumb@last}
         <a href="#top">{$crumb.label}</a>
      {else}
         <a href="{$crumb.uri}">{$crumb.label}</a>
      {/if}
      {assign var="separator" value=" | "}
   {/foreach}
   <br>&nbsp;
</div>

<div>
<a name="top"><p>&nbsp;</p></a>
</div>


<table border='0'>
<tr valign='top'>

{foreach $fileDict as $record}
   {if ($record@iteration -1) is div by 4}
      </tr><tr valign='top'>
   {/if}

   <td align='center' style="padding: .5em;">
      {if $record.dir != ""}
         <a href="index.php?page={$page}/{$record.dir}">
      {elseif $record.lnk != ""}
         <a href="{$record.lnk}">
      {else}
         <a href="{$page}/{$record.img}">
      {/if}
   
      {if $record.thu != ""}
         <img src='{$page}/{$record.thu}'><br/>
      {else}
         <img src='Icons/nothumb.png'><br/>
      {/if}
      </a>
   
      <!-- <span style="white-space: nowrap;"> -->
      <span>
         {if     $record.dir != ""} {$record.dir} 
         {elseif $record.lnk != ""} External Link
         {else}                     {$record.img}
         {/if}
      </span>
      <br/>
   </td>
{/foreach}
</tr>
</table>

</body>
</html>
{/nocache}
