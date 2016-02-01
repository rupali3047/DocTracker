<?php
function testimonial($uma,$shankar,$sahoo)
{
	$var="<table border=\"0\" width=\"100%\">";
	$var.="<tbody>";
	$var.="<tr>";
	$var.="<td style=\"text-align: justify;\" width=\"495px\">";
	$var.=$uma;
	$var.="</td>";
	$var.="<td width=\"179px\"><img src=\"";
	$var.="$sahoo";
	$var.="\" height=\"86\" width=\"79\"></td></tr>";
	$var.="<tr>	<td colspan=\"2\" align=\"right\"><strong>";
	$var.=$shankar;
	$var.="</strong></td></tr></tbody></table>";
	echo "$var";
}
?>