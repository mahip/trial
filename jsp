<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<div class="certificate-page-container">
	<div id="certDisFormCont">
		<form:form id="discover-certificate" method="POST"
			modelAttribute="certDiscoveryHistory" name="discover-certificate"
			action="javascript:void(0)" enctype="multipart/form-data">
		<div class="row-fluid certDiscoveryCtrl">
			<!-- <h4 style="font-size:13px;padding-left:1%;margin:10px 0 5px;">Discover mode</h4> -->
			<div class="certDeviceRadioHolder">
				<form:hidden path="certDiscoveryMode" id="certDiscoveryModeId"/>
				<form:hidden path="portsMode" id="portsModeId"/>
				<form:hidden path="id" id="certDiscoveryId"/>
				
				<input class="radioBtn" type="radio" checked="checked" value="range" name="discoveryMode" id="range-radio" onclick="clearAlerts();clearMessage();">IP Range 
				<input class="radioBtn" type="radio" value="subnet" name="discoveryMode" id="subnet-radio" onclick="clearAlerts();clearMessage();">Subnet
				<input class="radioBtn" type="radio" value="single" name="discoveryMode" id="single-radio" onclick="clearAlerts();clearMessage();">URL
				<input class="radioBtn" type="radio" value="upload" name="discoveryMode" id="upload-radio" onclick="clearAlerts();clearMessage();">Upload
				<input class="radioBtn" type="radio" value="managedDevices" name="discoveryMode" id="managedDevices-radio" onclick="clearAlerts();clearMessage();">Managed Devices
			</div>
		</div>
			<div class="certDiscoveryCtrl">
				<div class="row-fluid cert-discover-form  ">
				<div class="certIpPortDiv">
					<label class="control-label spnStartIp" for="inputEmail">Start
						IP</label>
					<%-- class="pull-left property"(property removed) --%>
					<form:input type="text" id="startIp" name="ips" path="startIp" 
						onclick="clearAlerts()" placeholder="192.168.1.0" class="ipWidth"></form:input>
					<span id="endIpSpan" style="margin-left:2%"> <label class="control-label spnEndIp" 
						for="inputEmail">End IP</label> <form:input type="text" id="endIp"
							name="masks" class="property range ipWidth" path="endIp" style="margin-left:4px;"
							onclick="clearAlerts()" placeholder="192.168.1.4"></form:input>
					</span> <span id="portSpan" style="font-weight:bold; margin-left:1% font-size:93%"> <input class="radioBtn" type="radio"
						value="knownport" name="portMode" id="subnetpart-radio"
						style="margin: 0 7px;" class="ipWidth" />Ports 
						<form:input type="text" id="portNo" class="portNoCert" name="ips" path="ports" style="margin-left:10px;"
							placeholder="443,8443"></form:input> <input class="radioBtn"
						type="radio" checked="checked" value="allport" name="portMode"
						id="rangepart-radio" style="margin: 0 5px 0 2%;">All Ports
					</span>
		 			<!-- <span style="position:absolute;" id="browseSpan" hidden = "true">
		 				
		 				 <input type="button" class="uploadButton" value="Browse" style="position:absolute;">
		 				<input type="file" id="certUpload" name="certFileUpload" style="position:absolute;height:25px;opacity:0;margin-left:-180px;" onchange="getFileContent(this);">
		 			 	
					</span> -->
				</div>
				<div>
				<span class="certPolicySpan">
						<label class="certPolicy">Cert Policy</label>
						<input type="text" id="id_certPolicy" class="ipWidth"></input>
				</span>
				</div>
				</div>
				
			</div>
			<div id="err-mess" style="margin-left: 53px;"></div>
			<div class="clear"></div>
			<div class="certButtons" style="margin-top:10px;">
				<span id="browseSpan" hidden = "true">
		 				
		 				 <input type="button" class="uploadButton" value="Browse">
		 				<input type="file" id="certUpload" name="certFileUpload" style="position:absolute;height:25px;opacity:0;margin-left:-180px;" onchange="getFileContent(this);">
		 			 	
				</span>
				<!-- <button class="uploadButton" type="file">Browse</button> -->
				<button class="cert-confirm-button btn-primary" type="button"
					id="id_certDiscover" onclick="clearAlerts();validateDiscover();">Discover</button>
				<button class="cert-cancel-button btn-secondary" type="button"
					id="id_certDiscoverReset" onclick="clearAlerts();resetValues();">Reset</button>
			</div>
			<div id="dialog-pwd" style="display:none" class="dialog-pwd">
				<span>
				<label for="password" class="floatLeft">Please Enter the Password&nbsp;&nbsp;</label>
				<input type="password" name="password" id="id_password" value="" class="text ui-widget-content ui-corner-all floatLeft">
				</span>
				<span id="id_err-msg" class="errMsgSpan"></span>
				<i>&nbsp;</i>
			</div>
		</form:form>
		<div style="text-align:center">progress bar coming soon</div>
		<!-- <div class="" style="margin-left: 25px; text-align: center;">

			<button class="cert-confirm-button btn-primary" type="button"
				id="id_certDiscoverMonitor" onclick="manage('Monitored')">Monitor</button>
			<button class="cert-confirm-button btn-primary" type="button"
				id="id_certDiscoverManage" onclick="manage('Managed')">Manage</button>
			<button class="cert-confirm-button btn-primary" type="button"
				id="id_certDiscoverIgnore" onclick="manage('Ignored')">Ignore</button>
		</div> -->
	</div>
	<div class="clear"></div>
	<div class="cert-item-selector cerDiscoveryTableContainer">
		<div class="discoveryTableHeader">
			<b><span class="totalDiscovered" id="total-discovered">Total : <span class="info-discvoer total-certs"></span>
			</span>
			<span class="totalDiscovered" id="total-discovered">Managed : <span class="info-discvoer managed-certs"></span>
			</span>
			<span class="totalDiscovered" id="total-discovered">Monitored : <span class="info-discvoer monitored-certs"></span>
			</span>
			<span class="totalDiscovered" id="total-discovered">Ignored : <span class="info-discvoer ignored-certs"></span>
			</span></b>
			<div class="pull-right">
				<img class="refreshBtn"
					src="resources/themes/default/img/icon-refresh.png"
					onclick="javascript:certDiscoverRefresh()"></img>
			</div>
		</div>
		<div id="dialog-confirm" style="display: none">
			<span></span><i>&nbsp;</i>
		</div>
		<div id="id_certDiscoverTable">
			<table id="certDiscoverTable"
				class="certDataTable dataGrid dataTableLeft stateChange ">
			</table>
		</div>
	</div>
</div>

<script type="text/javascript" src="resources/script/certificate/certDiscoveryHandler.js"></script>

<!-- function getFileContent(input){
     document.getElementById('startIp').value=document.getElementById('certUpload').value;
}

$(document).ready(function() {
//	if(!AVX_MDULS.viewWorkOrder){
	if(!AVX_GLBLS.viewWorkOrder){
		$('.cert-menu-view').hide();
	}
	CURRENT_PAGE_INDEX = CONSTANTS.CERT_DISCOVERY_VIEW; 
	//resetValues();
				
	createCertDiscoveryDataGrid();
	$('#portNo').val("");
	$("#portNo").attr("disabled",true);
	
	// Hide by default. certDiscoveryModeId may not have initial value.
	$("#browseSpan").hide();
	
	/**
	var startIpPlaceHolderConfig = {};
	startIpPlaceHolderConfig.parentSelector = '.cert-discover-form';
	startIpPlaceHolderConfig.inputSelector = '#startIp';
	startIpPlaceHolderConfig.placeHolderVal = '192.168.1.0';
	startIpPlaceHolderConfig.showPlaceHolderOnFocusOut = 'false';
	searchTextonFocus(startIpPlaceHolderConfig);
	*/
	
	// Used for Selecting the discovery radio button default -->
<%-- 
	if ($('#certDiscoveryModeId').val() == "RANGE") {
		$('#range-radio').attr('checked', true);
		$(".spnStartIp").html("Start IP");
		$("#id_certDiscover").html("Discover");
		$("#endIpSpan").show();
		$("#portSpan").show();
		$("#browseSpan").hide();
		$(".spnEndIp").html("End IP");
		$("#endIp").addClass('range').removeClass('subnet')
				.removeClass('single');
		$("#startIp").show();
		 $('#startIp').attr('placeholder','192.168.1.1');
	} else if ($('#certDiscoveryModeId').val() == "SUBNET") {
		$('#subnet-radio').attr('checked', true);
		 $(".spnStartIp").html("Network");
		 $("#id_certDiscover").html("Discover");
		 $('#startIp').attr('placeholder','192.168.1.1/24');
		$("#endIpSpan").hide();
		$("#portSpan").show();
		$("#browseSpan").hide();
		$('#startIp').val($('#startIp').val() + "/" + $('#endIp').val());
		$("#endIp").addClass('subnet').removeClass('range')
				.removeClass('single');
		$("#startIp").show();
	} else if ($('#certDiscoveryModeId').val() == "SINGLE_DEVICE") {
		$('#single-radio').attr('checked', true);
		$(".spnStartIp").html("URL");
		$("#id_certDiscover").html("Discover");
		 $(".rangepart-radio").attr('checked',true);
		$("#endIpSpan").hide();
		$("#portSpan").hide();
		$("#browseSpan").hide();
		$("#endIp").addClass('single').removeClass('range').removeClass('subnet');
		 $('#startIp').attr('placeholder','https://www.google.com');
	}
	else if ($('#certDiscoveryModeId').val() == "UPLOAD_CERTIFICATE") {
		$('#upload-radio').attr('checked', true);
		$("#id_certDiscover").html("Upload");
		$(".spnStartIp").hide().html("");
		$("#endIpSpan").hide();
		$("#portSpan").hide();
		$("#browseSpan").show();
		$("#startIp").show().css('margin-left','0px');
		//$("#startIp").css("width","206px");
		//$("#startIp").css("disabled",true);
		//$('#startIp').val('');
		$('#startIp').val('').attr('placeholder','');
	}
	
	$("#upload").unbind("click");
	$("#upload").click(
		function()
		{
			if ($(this).is(":visible"))
			{
				document.getElementById('certUpload').click();
			}
		}
		);
});
	$("input[name='discoveryMode']").change(
			function(event) {
				if (this.value == 'range') {
					 $(".spnStartIp").html("Start IP");
					$("#endIpSpan").show();
					$("#portSpan").show();
					$("#id_certDiscover").html("Discover");
					$("#browseSpan").hide();
					$(".spnEndIp").html("End IP");
					$("#endIp").addClass('range').removeClass('subnet')
							.removeClass('single');
					$("#startIp").show();
					 $('#startIp').attr('placeholder','192.168.1.1');
	
				} else if (this.value == 'subnet') {
					 $(".spnStartIp").html("Network");
					 $('#startIp').attr('placeholder','192.168.1.1/24');
					 $("#id_certDiscover").html("Discover");
					$("#endIpSpan").hide();
					$("#portSpan").show();
					$("#browseSpan").hide();
					$("#endIp").addClass('subnet').removeClass('range')
							.removeClass('single');
					$("#startIp").show();
				} else if (this.value == 'single') {
					 $(".spnStartIp").html("URL");
					 $(".rangepart-radio").attr('checked',true);
					 $("#id_certDiscover").html("Discover");
					$("#endIpSpan").hide();
					$("#portSpan").hide();
					$("#browseSpan").hide();
					$("#endIp").addClass('single').removeClass('range')
							.removeClass('subnet');
					$("#startIp").show();
					 $('#startIp').attr('placeholder','https://www.google.com');
				}
				else if (this.value == 'upload') {
					$(".spnStartIp").hide().html("");
					$("#id_certDiscover").html("Upload");
					$("#endIpSpan").hide();
					$("#portSpan").hide();
					$("#browseSpan").show();
					$("#startIp").show().css('margin-left','0px');
					//$("#startIp").css("width","206px");
					//$("#startIp").html("Upload");
					$('#startIp').attr('placeholder','');
				}
	});
	


	$("input[name='portMode']").change(function(event) {
		
		if (this.value == 'knownport') {
			$("#portNo").val('443,8443');
			$("#portNo").attr("disabled",false);
		} else {
			$("#portNo").val('');
			$("#portNo").attr("disabled",true);
		}
		
		
	});
	
	function getDate(a){
		var dateSplit = $(a).text().split('/');
        var x = (dateSplit[2] + dateSplit[1] + dateSplit[0]) * 1;
        return x;
	}

	jQuery.fn.dataTableExt.oSort['date-sort-asc'] = function(a, b) {      
        var x = getDate(a);
        var y = getDate(b);
        var z = ((x < y) ? -1 : ((x > y) ? 1 : 0));
        return z;
	};

	jQuery.fn.dataTableExt.oSort['date-sort-desc'] = function(a, b) {
        var x = getDate(a);
        var y = getDate(b);
        var z = ((x < y) ? 1 : ((x > y) ? -1 : 0));
        return z;
    };
    
    var discoverCertDeviceDataTable = "";
	function createCertDiscoveryDataGrid() {
		var certlogNumRows = 0;
		var certDiscoveryTableHt = $(window).height() - (430);
		certlogNumRows = parseInt(Math.floor((certDiscoveryTableHt / 20)).toFixed(0));
		$("#id_certDiscoverTable").empty();
		$("#id_certDiscoverTable").html('<table id="certDiscoverTable" class="certDataTable dataGrid dataTableLeft stateChange "></table>');
		
		$.fn.dataTableExt.sErrMode = 'throw';
		var managedCertificates = 0;
		var monitoredcertificates = 0;
		var ignoredcertificates = 0;

		var id = $('#certDiscoveryId').val();
		discoverCertDeviceDataTable = $('#certDiscoverTable').dataTable({
			"bProcessing" : true,
			"bPaginate" : false,
			"sDom": "Rlfrtip", // For column resizing. // Commented out column resizing as it breaks row filtering.
			"bDestroy": true,
			"bSortClasses" : true,
			"bFilter" : true,
			"aaSorting": [[ 3, "asc" ]],
		    "sScrollY" :certDiscoveryTableHt, 
		    "sScrollX" : '100%',
			"iDisplayLength" :certlogNumRows,
			"sAjaxDataProp" : "data",
			"bLengthChange" : false,
			"bStateSave": true,
			"sAjaxSource": "<%=request.getContextPath()%>/getAllDiscoveredCertificates.do?id=" + id,
							"fnInitComplete" : function(oObj, json) {
								checkStatusCode(oObj.jqXHR);
									AVX_MDULS.threadStatus = json.threadStatus;
									var filter  = "<tr id = 'discoverCert' class = 'searchDivTemplate searchDivCertWo certReportSearchFilter'>"
										+ "<th><input type='hidden' name='search_engine' class='search_init'/></th>"
										+ "<th><input type='hidden' name='search_engine' class='search_init'/></th>"
										+ "<th><input type='text' name='deviceName' class='search_init'/></th>"
										+ "<th><input type='text' name='deviceIpCertnodeIp' class='search_init'/></th>"						
										+ "<th><input type='text' name='subject' class='search_init'/></th>"
										+ "<th><input type='text' name='serialNumber' class='search_init'/></th>"
										+ "<th><input type='text' name='expiryDateStr' class='search_init'/></th>"
										+ "<th><input type='text' name='issuerCommonName' class='search_init'/></th>"
										+ "<th><input type='text' name='status' class='search_init'/></th>"
										//+ "<th><input type='text'name='lastRunDate' id='lRun' class='search_init'/></th>"
										$(oObj.nTHead).append(filter);
										$("th input").keyup( function () {
						            		discoverCertDeviceDataTable.fnFilter( this.value, ($("th input").index(this)-1));
						        		});
								AVX_MDULS.loadIcon('.item-selector-header h1');
								$('.cert-loader').hide();
								checkStatus(json.threadStatus);	
							},
							"aoColumns" : [
							               
									{
										"mDataProp" :"none",
										"sDefaultContent" : "",
										"sTitle" : "<i class='column-expand  plus-icon' style='text-align:center;'></i>",
										"sWidth" : "14px",
										"sClass" : "center-columns",
										"bSortable":false,
										"fnRender" : function(obj, val) {
											var flag=false;
											if(obj.aData.deviceId!="undefined" && obj.aData.deviceId!=null && obj.aData.deviceId.length>1 ){
												flag=true;
											} 
											if(obj.aData.subject!="undefined" && obj.aData.subject!=null && obj.aData.subject.split(",").length>1){
												flag=true;
											}
											if(flag){
												return "<i  class='row-expand devicelist plus-icon'>&nbsp;</i>";
											}	
											else{
												return "<i  class='devicelist minus-icon'>&nbsp;</i>";
											}
										}	
									},
									{
										"mDataProp" : "validUntil",
										"sWidth" : "14px",
										"sTitle" : "<input type='checkbox' class='check_all' onclick='selectAllChecks()'/>",
										"sClass" : "center-columns",
										"bSortable" : false,
										"bSearchable" : false,
										"fnRender" : function(obj, val) {
											if (obj.aData.status === 'Managed') {
												return "<input type='checkbox' id='selectCheck' value='"+obj.aData.id+"' status='"+obj.aData.status+"' class='check' />";
											} else {
												return "<input type='checkbox' id='selectCheck' value='"
														+ obj.aData.id
														+ "' status='"
														+ obj.aData.status
														+ "' class='check' onclick='selectChecks()' />";
											}
										}

									},
									{
										"mDataProp" : "deviceName",
										"sWidth" : "10%",
										"sTitle" : "Common Name",
										"sClass" : "cert-discover",
										"fnRender" : function(obj) {
											var currentDate = new Date();
											var date = obj.aData.expiryDateStr
													.split("/");
											var expiryDate = new Date(date[2],
													date[1] - 1, date[0]);
											if (currentDate > expiryDate) {
												statusClass = 'expired';
											} else {
												statusClass = 'valid';
											}
											return '<div class="collapse"><span class="activeSpan"><i class="'+statusClass+'"/>'
													+ obj.aData.subjectCommonName
													+ '</span></div>';
										}
									},
									{
										"mDataProp" : "deviceIpCertnodeIp",
										"sWidth" : "7%",
										"sTitle" : "Discovered IP",
										"sClass" : "cert-discover",
										"fnRender" : function(obj) {
											var deviceIpCertnodeIp = obj.aData.deviceIpCertnodeIp;
											var span = "";
											$(deviceIpCertnodeIp).each(function() {
												span+="<span class='activeSpan'>"+ this.deviceIP+"</span><br>";
											});
											return "<div class='collapse'>"+span+"</div>";
										}
									},
									{

										"mDataProp" : "subjectDomainName",
										"sWidth" : "10%",
										"sTitle" : "Subject",
										"sClass" : "cert-discover",
										"fnRender" : function(obj) {

											var myarray = obj.aData.subject
													.split(",");
											var profileData = null;
											for ( var i = 0; i < myarray.length; i++) {
												if (i == 0) {
													profileData = myarray[i];
												} else {
													profileData = profileData
															+ "<br>"
															+ myarray[i];
												}

											}
											return "<div class='collapse'><span class='activeSpan'>"
													+ profileData
													+ "</span></div>";
										}

									},

									{
										"mDataProp" : "serialNumber",
										"sWidth" : "10%",
										"sTitle" : "Serial Number",
										"sClass" : "cert-discover",
										"fnRender" : function(obj) {
											return "<span class='activeSpan'>"
													+ obj.aData.serialNumber
													+ "</span>";
										}

									},
									{
										"mDataProp" : "expiryDateStr",
										"sWidth" : "7%",
										"sTitle" : "Valid Until",
										"sClass" : "cert-discover",
										"sType" : "date-sort",
										"fnRender" : function(obj) {
											return "<span class='activeSpan'>"
													+ obj.aData.expiryDateStr
													+ "</span>";
										}

									},
									{
										"mDataProp" : "issuerCommonName",
										"sWidth" : "7%",
										"sTitle" : "Issuer",
										"sClass" : "cert-discover",
										"fnRender" : function(obj) {
											return "<span class='activeSpan'>"
													+ obj.aData.issuerCommonName
													+ "</span>";
										}

									},
									{
										"mDataProp" : "status",
										"sWidth" : "7%",									
										"sTitle" : "Status",
										"sClass" : "cert-discover",
										"fnRender" : function(obj) {
											if(obj.aData.status=='Monitored'){
												monitoredcertificates+=1;
											}else if(obj.aData.status=='Managed'){
												managedCertificates+=1;
											}
											else if(obj.aData.status=='Ignored'){
												ignoredcertificates+=1;
											}										
												
											return "<span class='activeSpan'>" + obj.aData.status
													+ "</span>";
										}

									} ],
							"fnDrawCallback" : function(oObj,json) {							
								$('.check_all').removeAttr("checked");
								enableMouseActionsOnDataTable();
								showBorderForLastRow();
								$('.total-certs').text(oObj.aiDisplay.length);
								$('.managed-certs').text(managedCertificates);
								$('.monitored-certs').text(monitoredcertificates);
								$('.ignored-certs').text(ignoredcertificates);
								var records = $('.info-discvoer').text();
								if (records == 0) {
									$('#certDiscoverTable_paginate').css(
											'display', 'none');
								} else {
									$('#certDiscoverTable_paginate').css(
											'display', 'inline-block');
								}
								expand(this);
								columnExpandAll();
								selectAllChecks();
								adjustColDataAccordingToColDimension(oObj);
							}
						});
			//filter
	        
	        AVX_GLBLS.clearDataTableFilter('#certDiscoverTable');
	        setTimeout("$('.dataTables_scrollBody').find('.dataTable').dataTable().fnAdjustColumnSizing(false);", 2000);
	}

	function resetValues() {

		$('#startIp').val("");
		$('#endIp').val("");
		$('#portNo').val("");
		$('#certUpload').val("");
	}

	function validateDiscover() {
		//debugger;
		$('.cert-loader').show();
		AVX_MDULS.loadIcon('.item-selector-header h1');
		var valid = false;
		var portSpecific = $('input[id="subnetpart-radio"]').is(":checked");
		var rangeSpecific = $('input:radio[name="discoveryMode"]:checked')
				.val();

		if (rangeSpecific == 'range') {
			if ($('#startIp').val() == "" || $('#endIp').val() == " ") {
				$('#err-mess').append(
						'<span class="err-msg">IP should not be empty</span>');
				valid = false;
			} else if ($('#startIp').val() == "") {
				if (portSpecific) {
					valid = (validateCertIp($('#endIp')))
							&& (validateCertPort($('#portNo')))
							&& (validateCertIpAddress($('#startIp'),
									$('#endIp')));
				} else {
					valid = (validateCertIp($('#endIp')))
							&& (validateCertIpAddress($('#startIp'),
									$('#endIp')));
				}
				$('#startIp').val($('#endIp').val());
			} else if ($('#endIp').val() == "") {
				if (portSpecific) {
					valid = (validateCertIp($('#startIp')))
							&& (validateCertPort($('#portNo')))
							&& (validateCertIpAddress($('#startIp'),
									$('#endIp')));
				} else {
					valid = (validateCertIp($('#startIp')))
							&& (validateCertIpAddress($('#startIp'),
									$('#endIp')));
				}
				$('#endIp').val($('#startIp').val());
			} else {
				if (portSpecific) {
					valid = (validateCertIp($('#startIp')))
							&& (validateCertIp($('#endIp')))
							&& (validateCertPort($('#portNo')))
							&& (validateCertIpAddress($('#startIp'),
									$('#endIp')));
				} else {
					valid = (validateCertIp($('#startIp')))
							&& (validateCertIp($('#endIp')))
							&& (validateCertIpAddress($('#startIp'),
									$('#endIp')));
				}
			}

		} else if (rangeSpecific == 'subnet') {
			if (portSpecific) {
				valid = (validateSubnetIp($('#startIp')))
						&& (validateCertPort($('#portNo')));
			} else {
				valid = (validateSubnetIp($('#startIp')));
			}
			if (valid) {
				var value = $('#startIp').val();
				var n = value.split("/");
				$('#startIp').val(n[0] + "/" + n[1]);
				$('#endIp').val(n[1]);
			}
		} else if (rangeSpecific == 'single') {

			var regex = new RegExp(
					"^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.|){1}([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?");
			if ($('#startIp') == "" || $('#startIp') == " ") {
				$('#err-mess').append(
						'<span class="err-msg">URL should not be empty</span>');
				valid = false;
			} else if (!regex.test($('#startIp').val())) {
				$('#err-mess')
						.append(
								'<span class="err-msg">Invalid URL(Valid eg:http://www.google.com)</span>');
				valid = false;
			} else {
				valid = true;
			}
		}
		else if(rangeSpecific == 'upload'){
			
			valid = true;
		}
			if(rangeSpecific == 'upload'){
				urlToSubmit = 'uploadCertificateDiscovery.do';
				$('.message-div').addClass('cert-message-div');
				$('.message-div.cert-message-div').css('top','0px');
			}
			else{
				urlToSubmit = 'discoverCertificateList.do';
				$('.message-div').addClass('cert-message-div');
				$('.message-div.cert-message-div').css('top','0px');
			}
		
		if (valid) {
			if(rangeSpecific == 'upload'){
				if(AVX_MDULS.isPkcs12($('#startIp').val())){
					AVX_MDULS.getPwdDialog(urlToSubmit, rangeSpecific);
				}
				else{
					AVX_MDULS.triggerRequest(urlToSubmit, rangeSpecific);
				}
			}
			else{
				AVX_MDULS.triggerRequest(urlToSubmit, rangeSpecific);
			}
		}
	}
	
	function checkStatus(status) {
		if (status == undefined || !status){
			AVX_MDULS.stopLoadIcon('.item-selector-header h1');
			return;
		}
		if (status) {
			AVX_MDULS.loadIcon('.item-selector-header h1');
			setTimeout(function(){
				createCertDiscoveryDataGrid();
			}, 5000);
		}
	}
	
	function selectChecks() {
		var isChecked = $('#selectCheck').is(':checked');
	}

	function manage(action) {
		AVX_MDULS.loadIcon('.item-selector-header h1');
		var allVals = [];
		if (getCertSelectedId() == null) {
			$('.certMessage').addClass('error');
			$('.certMessage span')
					.html("<spring:message code='error.update'/>");
			AVX_MDULS.stopLoadIcon('.item-selector-header h1');
			bindCloseEvents();
		} else {
			$(':checkbox:checked').each(function() {
				if ($(this).val() != 'on') {
					var tmp = $(this).val();
					allVals.push(tmp.replace(/,/g, "##"));
				}
			});
			if (allVals.length > 0) {
				$
						.ajax({
							url : "manageCertificates.do",
							data : "certDiscIDs=" + allVals + "&action="
									+ action,
							type : "post",
							success : function(result,status,xhr) {
								checkStatusCode(xhr);
								createCertDiscoveryDataGrid();
								$('.certMessage').removeClass('error')
										.addClass('success');
								$('.certMessage span')
										.text(
												"<spring:message code='success.update'/>");
								bindSuccessEvents();
							},
							error : function(result) {
								createCertDiscoveryDataGrid();
								$('.certMessage').removeClass('success')
										.addClass('error');
								$('.certMessage span')
										.text(
												"<spring:message code='error.operationFailed'/>");
								AVX_MDULS.stopLoadIcon('.item-selector-header h1');
								bindCloseEvents();
							}
						});
			} else {
				$('.certMessage').addClass('error');
				$('.certMessage span').html(
						"<spring:message code='error.delete'/>");
				AVX_MDULS.stopLoadIcon('.item-selector-header h1');
				bindCloseEvents();
			}
		}
	}

	function getCertSelectedId() {
		var row = $('.dataGrid').find('.row-selected');

		var id = null;
		$(row).each(function() {
			id = $(this).find('input').attr('value');
		});
		return id;
	}

	function clearDevice(obj) {
		$('.certMessage').css('width', '91.5%');
		var allVals = [];
		var xPos = $(obj).offset().left;
		var yPos = $(obj).offset().top;
		$(':checkbox:checked').each(function() {
			if ($(this).val() != 'on') {
				var tmp = $(this).val();
				allVals.push(tmp.replace(/,/g, "##"));
			}
		});
		if (allVals.length > 0) {
			$("#dialog-confirm")
					.dialog(
							{
								resizable : false,
								title : "Clear Certificate(s)",
								maxHeight : 300,
								minHeight : 100,
								position : [ xPos - 240, yPos + 26 ],
								modal : false,
								draggable : false,
								dialogClass : 'confirm-delete',
								open : function(event, ui) {
									$(document)
											.bind(
													'click',
													function(e) {
														if (!$(e.target)
																.hasClass(
																		'clearBtn')) {
															$(
																	'.ui-dialog-buttonset .cancel-button')
																	.trigger(
																			'click');
														}
													});
								},
								buttons : {
									"Yes" : {
										'text' : 'Yes',
										'class' : 'btn delete-button',
										'click' : function() {
											$
													.ajax({
														type : "post",
														url : "deleteDiscoverCertificate.do",
														data : {
															serialNumbers : allVals
														},
														success : function(msg,status,xhr) {
															checkStatusCode(xhr);
															$('.certMessage')
																	.removeClass(
																			'error')
																	.addClass(
																			'success');
															$(
																	'.certMessage span')
																	.text(
																			"<spring:message code='success.delete'/>");
															bindSuccessEvents();
															createCertDiscoveryDataGrid();
														},
														error : function(msg) {
															$('.certMessage')
																	.removeClass(
																			'success')
																	.addClass(
																			'error');
															$(
																	'.certMessage span')
																	.text(
																			"<spring:message code='error.operationFailed'/>");
															AVX_MDULS.stopLoadIcon('.item-selector-header h1');
															bindCloseEvents();
														}
													});
										}
									},
									"No" : {
										'text' : 'No',
										'class' : 'btn cancel-button',
										'click' : function() {
											$(this).dialog("destroy");
										}
									}
								}
							});
		} else {
			$('.certMessage').addClass('error');
			$('.certMessage span')
					.html("<spring:message code='error.delete'/>");
			AVX_MDULS.stopLoadIcon('.item-selector-header h1');
			bindCloseEvents();
		}
	}


	function certDiscoverRefresh() {
		createCertDiscoveryDataGrid();
	}

	function clearAlerts() {
		$('.err-msg').css({
			'display' : 'none'
		});
	}

	function clearMessage() {
		$('#startIp').val('');
		$('#endIp').val('');
	}
	
	AVX_MDULS.getPwdDialog = function(urlToSubmit, rangeSpecific){
		$( "#dialog-pwd" ).dialog({
			autoOpen: false,
			height: 100,
			width: 450,
			modal: true,
			resizable: false,
			draggable:false,
			buttons: {
				"Ok":{
					'text':'Ok',
					'class':'btn btn-primary delete-button',
					'click':function() {
						if($('#id_password').val().length!=0){
								AVX_MDULS.triggerRequest(urlToSubmit, rangeSpecific);
							}
							else{
								$('#id_err-msg').html("Password cannot be empty&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
							}
				}
				},
				"Cancel": {
					'text':'Cancel',
					'class':'cancelBtn',
					'click':function() {
						AVX_MDULS.clearDialogInputs();
						$( this ).dialog( "destroy" );
					}
				}
		}
		});

		$( "#dialog-pwd" ).dialog( "open" );
		$("#dialog-pwd").siblings('div.ui-dialog-titlebar').remove();
	};
		
	AVX_MDULS.triggerRequest = function(urlToSubmit, rangeSpecific){
		$('#discover-certificate').attr('action', urlToSubmit);
		$('#discover-certificate')
				.ajaxSubmit(
						{
							data : {
								password : $('#id_password').val()
							},
							success : function(msg) {								
								$('#certDiscoveryId').val(msg);
								if(rangeSpecific == 'upload'){
									if(msg == "Password Mismatch"){
										$('#id_err-msg').html(msg+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
									}else{
									AVX_MDULS.clearDialogInputs();
									AVX_MDULS.closeDialog("dialog-pwd");
									$('.message-div').removeClass('error').addClass('success');
									$('.message-div.success span').text("Uploaded Successfully!!");
									bindSuccessEvents();
								}
								}
								$('.message-div').removeClass('error').addClass('success');
								$('.message-div.success span').text("Discovery triggered successfully. Please refresh the page after some time.");
								bindSuccessEvents();
								 createCertDiscoveryDataGrid();
							},
							error : function(msg) {
								if(rangeSpecific == 'upload'){
									AVX_MDULS.clearDialogInputs();
									$('.message-div').removeClass('success')
									.addClass('error');
									$('.message-div.error span')
									.text("Upload Failed");
								}else{
									$('.message-div').removeClass('success')
										.addClass('error');
									$('.message-div.error span')
										.text(msg.responseText);
									
								}
								AVX_MDULS.stopLoadIcon('.item-selector-header h1');
								$('.cert-loader').hide();
								bindCloseEvents();
								return;
							}
						});	
	};
</script>

 --%>
