
    use assignment2_congwen;
  
	
    # Implement Triggers
    
    # Website
    
    #insert
    
    delimiter //
    
    drop trigger if exists after_web_role_insert//
    
    create trigger after_web_role_insert
    after insert on website_role for each row
    begin
    
    case
    when new.role='owner'
    then insert into website_priviledge values(null, new.developer_id, new.web_id, 'create'), 
    (null, new.developer_id, new.web_id,'read'), 
    (null, new.developer_id, new.web_id,'update'), 
    (null, new.developer_id, new.web_id,'delete');
    
    when new.role='admin'
    then insert into website_priviledge values(null, new.developer_id, new.web_id, 'create'), 
    (null, new.developer_id, new.web_id,'read'), 
    (null, new.developer_id, new.web_id,'update'), 
    (null, new.developer_id, new.web_id,'delete');
    
    when new.role='writer'
    then insert into website_priviledge values(null, new.developer_id, new.web_id, 'create'), 
    (null, new.developer_id, new.web_id,'read'), 
    (null, new.developer_id, new.web_id,'update');
    
    when new.role='editor'
    then insert into website_priviledge values
    (null, new.developer_id, new.web_id,'read'), 
    (null, new.developer_id, new.web_id,'update');
    
    when new.role='reviewer'
    then insert into website_priviledge values
    (null, new.developer_id, new.web_id,'read');
    
    end case;
    end//
    
	
    
    #update
    
    delimiter //
    
    drop trigger if exists after_web_role_update//
    
    create trigger after_web_role_update
    after update on website_role for each row
    begin
    
    delete from website_priviledge where website_priviledge.developer_id=old.developer_id 
								and website_priviledge.web_id=old.web_id;
    begin
     case
     when new.role='owner'
     then insert into website_priviledge values(null, new.developer_id, new.web_id, 'create'), 
    (null, new.developer_id, new.web_id,'read'), 
    (null, new.developer_id, new.web_id,'update'), 
    (null, new.developer_id, new.web_id,'delete');
    
    when new.role='admin'
    then insert into website_priviledge values(null, new.developer_id, new.web_id, 'create'), 
    (null, new.developer_id, new.web_id,'read'), 
    (null, new.developer_id, new.web_id,'update'), 
    (null, new.developer_id, new.web_id,'delete');
    
    when new.role='writer'
    then insert into website_priviledge values(null, new.developer_id, new.web_id, 'create'), 
    (null, new.developer_id, new.web_id,'read'), 
    (null, new.developer_id, new.web_id,'update');
    
    when new.role='editor'
    then insert into website_priviledge values
    (null, new.developer_id, new.web_id,'read'), 
    (null, new.developer_id, new.web_id,'update');
    
    when new.role='reviewer'
    then insert into website_priviledge values
    (null, new.developer_id, new.web_id,'read');
    
    end case;
    end;
    end//
    
	
    
    #delete
    
    delimiter //
    
    drop trigger if exists after_web_role_delete//
    
    create trigger after_web_role_delete
    after delete on website_role for each row
    begin
    
    delete from website_priviledge where website_priviledge.developer_id=old.developer_id 
								and website_priviledge.web_id=old.web_id;
    end//
    
	
    
   
    #Page
    
    
    #insert
    
    delimiter //
    
    drop trigger if exists after_page_role_insert//
    
    create trigger after_page_role_insert
    after insert on page_role for each row
    begin
    
    case
    when new.role='owner'
    then insert into page_priviledge values(null, new.developer_id, new.page_id, 'create'), 
    (null, new.developer_id, new.page_id,'read'), 
    (null, new.developer_id, new.page_id,'update'), 
    (null, new.developer_id, new.page_id,'delete');
    
    when new.role='admin'
    then insert into page_priviledge values(null, new.developer_id, new.page_id, 'create'), 
    (null, new.developer_id, new.page_id,'read'), 
    (null, new.developer_id, new.page_id,'update'), 
    (null, new.developer_id, new.page_id,'delete');
    
    when new.role='writer'
    then insert into page_priviledge values(null, new.developer_id, new.page_id, 'create'), 
    (null, new.developer_id, new.page_id,'read'), 
    (null, new.developer_id, new.page_id,'update');
    
    when new.role='editor'
    then insert into page_priviledge values
    (null, new.developer_id, new.page_id,'read'), 
    (null, new.developer_id, new.page_id,'update');
    
    when new.role='reviewer'
    then insert into page_priviledge values
    (null, new.developer_id, new.page_id,'read');
    
    end case;
    end//
    
	
    
    
    #update
    
    delimiter //
    
    drop trigger if exists after_page_role_update//
    
    create trigger after_page_role_update
    after update on page_role for each row
    begin
    
    delete from page_priviledge where page_priviledge.developer_id=old.developer_id 
								and page_priviledge.page_id=old.page_id;
							
    begin
    case
    when new.role='owner'
    then insert into page_priviledge values(null, new.developer_id, new.page_id, 'create'), 
    (null, new.developer_id, new.page_id,'read'), 
    (null, new.developer_id, new.page_id,'update'), 
    (null, new.developer_id, new.page_id,'delete');
    
    when new.role='admin'
    then insert into page_priviledge values(null, new.developer_id, new.page_id, 'create'), 
    (null, new.developer_id, new.page_id,'read'), 
    (null, new.developer_id, new.page_id,'update'), 
    (null, new.developer_id, new.page_id,'delete');
    
    when new.role='writer'
    then insert into page_priviledge values(null, new.developer_id, new.page_id, 'create'), 
    (null, new.developer_id, new.page_id,'read'), 
    (null, new.developer_id, new.page_id,'update');
    
    when new.role='editor'
    then insert into page_priviledge values
    (null, new.developer_id, new.page_id,'read'), 
    (null, new.developer_id, new.page_id,'update');
    
    when new.role='reviewer'
    then insert into page_priviledge values
    (null, new.developer_id, new.page_id,'read');
    
    end case;
    end;
    end//
    
	

    #delete
    
    delimiter //
    
    drop trigger if exists after_page_role_delete//
    
    create trigger after_page_role_delete
    after delete on page_role for each row
    begin
    
    delete from page_priviledge where page_priviledge.developer_id=old.developer_id 
								and page_priviledge.page_id=old.page_id;
                                
    end//
