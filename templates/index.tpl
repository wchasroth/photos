{nocache}
<html>
<head>
   <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto">
   <style type="text/css">
      body, td, div { font-family: 'Roboto', sans-serif; }
   </style>
</head>
<body>

{assign var="separator" value=""}
&nbsp;&nbsp;
{foreach $breadcrumb as $crumb}
   {$separator}
   {if $crumb@last}
      {$crumb.label}
   {else}
      <a href="{$crumb.uri}">{$crumb.label}</a>
   {/if}
   {assign var="separator" value=" | "}
{/foreach}

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
