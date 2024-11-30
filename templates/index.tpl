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
{foreach $breadcrumb as $crumb}
   {$separator} <a href="{$crumb.uri}">{$crumb.label}</a>
   {assign var="separator" value="=&gt;"}
{/foreach}

<table border='0'>
<tr valign='top'>

{foreach $fileDict as $record}
   {if ($record@iteration -1) is div by 4}
      </tr><tr valign='top'>
   {/if}

   <td style="position: relative; padding: .5em;">
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
      <br/>
   
      <div style="position: absolute; bottom: 0; text-align: center; width: 100%;">
         <span style="white-space: nowrap;">
            {if     $record.dir != ""} {$record.dir} 
            {elseif $record.lnk != ""} External Link
            {else}                     {$record.img}
            {/if}
         </span>
         <br/>
      </div>
   </td>
{/foreach}
</tr>
</table>

</body>
</html>
{/nocache}
