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
   {if $record@iteration is div by 4}
      </tr><tr valign='top'>
   {/if}

   <td style="position: relative; padding: .5em;">
      {if $record.dir != ""}
         <a href="index.php?page={$page}/{$record.dir}">
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
         {if $record.dir != ""}
            {$record.dir}<br/>
         {else}
            {$record.img}</br>
         {/if}
      </div>
   </td>
{/foreach}
</tr>
</table>

</body>
</html>
{/nocache}
