public with sharing class NGFileUploadController {
	public String ParentId {get;set;}
	public Attachment[] attachments {get;set;}
	public NGFileUploadController() {
		if(ApexPages.currentPage().getParameters().get('ParentId') != null){
			ParentId = ApexPages.currentPage().getParameters().get('ParentId');	
			attachments = [select id,name,ContentType  from Attachment where parentId = :parentId order by lastmodifieddate desc limit 10];
		}
		else if(ApexPages.currentPage().getParameters().get('id') != null)
		{
			ParentId = ApexPages.currentPage().getParameters().get('id');	
			attachments = [select id,name,ContentType  from Attachment where parentId = :parentId order by lastmodifieddate desc limit 10];
		}

		//truncate file names so they fit
		if(attachments != null)
		{
				for(Attachment a:attachments)
				{
					if(a.name != null && a.name.contains('.'))
					{
						String ext = a.name.substring(a.name.lastIndexOf('.')+1);
						a.ContentType =fileTypeStyleMap.get(ext.toUpperCase());	
					}
					else
					{
						a.ContentType ='sprite-doctype_unknown_16';
					}

					if(a.name.length() > 25)
					{
						a.name = a.name.substring(0, 25) + '...';
					}
					
				}
		}
	}
		private Map<String, String> fileTypeStyleMap = new Map<String, String>
		{
	        'BMP' => 'sprite-doctype_image_16',
	        'CSV' => 'sprite-doctype_csv_16',
	        'XLS' => 'sprite-doctype_excel_16',
	        'XLSX' => 'sprite-doctype_excel_16',
	        'EXE' => 'sprite-doctype_exe_16',
	        'GIF' => 'sprite-doctype_image_16',
	        'JPG' => 'sprite-doctype_image_16',
	        'MOV' => 'sprite-doctype_video_16',
	        'MP4' => 'sprite-doctype_mp4_16',
	        'PDF' => 'sprite-doctype_pdf_16',
	        'PNG' => 'sprite-doctype_image_16',
	        'PPT' => 'sprite-doctype_ppt_16',
	        'PPTX' => 'sprite-doctype_ppt_16',
	        'RTF' => 'sprite-doctype_rtf_16',
	        'TEXT' => 'sprite-doctype_txt_16',
	        'TXT' => 'sprite-doctype_txt_16',
	        'UNKNOWN' => 'sprite-doctype_unknown_16',
	        'VISIO' => 'sprite-doctype_visio_16',
	        'DOC' => 'sprite-doctype_word_16',
	        'DOCX' => 'sprite-doctype_word_16',
	        'XML' => 'sprite-doctype_xml_16',
	        'ZIP' => 'sprite-doctype_zip_16'
		};		
}