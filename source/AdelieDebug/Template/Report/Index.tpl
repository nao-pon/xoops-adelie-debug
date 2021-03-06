<style><{$css}></style>
<div class="adelieDebug">
	<p class="h1">
		<span>Adelie Debug</span>
		<{if $isBuild}>
			<span style="font-size: 12px;">(Build <{'YmdHis'|date:$buildTime}>)</sapn>
		<{else}>
			<span style="font-size: 12px;">(Source)</sapn>
		<{/if}>
		<span style="font-size: 12px;"> <{if $isAdmin}>Admin<{else}>Safe<{/if}> mode</sapn>
	</p>
	<p class="h2">Errors</p>
	<{foreach from=$errorSummary key="typeName" item="ids"}>
		<div class="msgError">
			<strong><{$typeName}> (<{$ids|@count}>)</strong>
			<span>...</span>
			<{foreach from=$ids item="id"}>
				<a href="#adelieDebugLogId<{$id}>" style="margin: 10px;" onclick="javascript:document.getElementById('adelieDebugDetail').style.display='block'">#<{$id}></a>
			<{/foreach}>
		</div>
	<{foreachelse}>
		<div class="msgSuccess">There is no error.</div>
	<{/foreach}>
	
	<p class="h3">Cheat Sheet</p>
	<div class="adelieDebugHelp">
		<span>adump([mixed[, mixed]])</span>
		<span>atrace()</span>
		<span>awhich(object|string)</span>
		<span>asynop(object|string)</span>
		<{*<span class="adelieDebugHelpMore"><a href="<{$xoops_url}>/index.php/debug/help/">more…</a></span>*}>
	</div>
	
	<div class="adelieDebugClearBoth"></div>
	<a onclick="javascript:document.getElementById('adelieDebugDetail').style.display='block'">[ open detail ]</a>
	<a onclick="javascript:document.getElementById('adelieDebugDetail').style.display='none'">[ close detail ]</a>
<div style="display:none;" id="adelieDebugDetail">

	<p class="h2">Timeline</p>
	<div id="adelieDebugPhpErrors">
		<table class="data">
			<tr>
				<th>ID</th>
				<th>ms</th>
				<th>Type</th>
				<th>Message</th>
			</tr>
		<{foreach from=$logs item="log"}>
			<tr>
				<td style="width: 10px;" id="adelieDebugLogId<{$log.id}>"><{$log.id}></td>
				<td style="width: 10px;"><{$log.ms}></td>
				<td><{$log.typeName}></td>
				<td>
					<{if $isAdmin}>
						<{assign var="message" value=$log.message}>
						<{assign var="info" value=$log.info}>
					<{else}>
						<{assign var="message" value=$log.message|replace:$sourceDir:'(adelie)'|replace:$htmlDir:'(html)'|replace:$trustDir:'(trust)'|replace:$sqlPrefix:'(prefix)'}>
						<{assign var="info" value=$log.info|replace:$sourceDir:'(adelie)'|replace:$htmlDir:'(html)'|replace:$trustDir:'(trust)'|replace:$sqlPrefix:'(prefix)'}>
					<{/if}>
					<{if $log.typeName == 'DUMP'}>
						<{$message}>
					<{elseif $log.typeName == 'SYNOPSYS'}>
						<{$message}>
					<{elseif $log.typeName == 'DELEGATE'}>
						<div style="font-size:12px;"><{$message|escape}></div>
					<{elseif $log.typeName == 'SQL'}>
						<{strip}>
						<pre class="info <{$log.typeName}>" style="position:relative;">
							<div style="height: 100%; width: <{$log.timePer}>%; background: #c8d9ab; position: absolute; top: 0; left: 0;"></div><{* TODO >> move to css *}>
							<div style="position: relative; "><{$message|escape}></div>
						</pre>
						<{/strip}>
						<{if $log.info}>
							<pre><{$info|escape}></pre>
						<{/if}>
					<{else}>
						<pre class="info <{$log.typeName}>"><{$message|escape}></pre>
						<{if $log.info}>
							<pre><{$info|escape}></pre>
						<{/if}>
					<{/if}>
				</td>
			</tr>
		<{/foreach}>
		</table>
	</div>

	<p class="h2">Sent Headers</p>
	<div id="adelieDebugSentHeaders">
		<{strip}>
		<pre class="console">
			<{foreach from=$sentHeaders item="header"}>
				<{$header}><br />
			<{/foreach}>
		</pre>
		<{/strip}>
	</div>
	<p class="h2">Requests</p>
	<div id="adelieDebugRequest">
		<{foreach from=$requests key="name" item="request"}>
			<{if $isAdmin || ($name != '$_SERVER' && $name != '$_SESSION')}>
				<p class="h3"><{$name}></p>
				<{if $request}>
					<table class="data">
						<tr>
							<th>Key</th>
							<th>Value</th>
						</tr>
						<{foreach from=$request key="key" item="value"}>
							<tr>
								<td><{$key}></td>
								<td><{$value|@var_dump}></td>
							</tr>
						<{/foreach}>
					</table>
				<{else}>
					<p>There is no values.</p>
				<{/if}>
			<{/if}>
		<{/foreach}>
	</div>
	<p class="h2">PHP Information</p>
	<{foreach from=$phpInfo key="categoryName" item="info"}>
		<p class="h3"><{$categoryName|ucwords}></p>
		<{if $info}>
			<table class="data">
				<tr>
					<th>Key</th>
					<th>Value</th>
				</tr>
				<{foreach from=$info key="key" item="value"}>
				<tr>
					<td><{$key}></td>
					<td><{$value}></td>
				</tr>
				<{/foreach}>
			</table>
		<{else}>
			<p>There is no values.</p>
		<{/if}>
	<{/foreach}>
</div>
</div>
