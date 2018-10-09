
  use assignment2_congwen;
 
  # Create Schema 

  #create person

   create table person
  (id integer(11) not null,
  primary key(id),
  firstname varchar(45),
  lastname varchar(45),
  username varchar(45) not null,
  `password` varchar(45) not null,
  email varchar(45),
  dob date );
  
  
  #create user
  
   create table `user`
   (id integer(11) not null,
   primary key(id),
   user_agreement boolean,
   constraint user_person_generalization 
   foreign key(id) references person(id) on delete cascade on update cascade,
   user_key varchar(45));
   
   
   #create developer
  
   create table developer
   (id integer(11) not null,
   primary key(id),
   developer_key varchar(45),
   constraint developer_person_generalization 
   foreign key(id) references person(id) on delete cascade on update cascade);
   
   
   #create website
   
   create table website
   (id integer(11) not null,
   primary key(id),
   `name` varchar(255),
   description varchar(255),
   created date,
   updated date,
   visits integer(11));
   
   
   #create page
   
   create table `page`
   (id integer(11) not null,
   primary key(id),
   web_id integer(11) not null,
   foreign key(web_id) references website(id) on delete cascade on update cascade,
   title varchar(255),
   description varchar(255),
   created date,
   updated date,
   views integer(11));
   
   
   #create Widget
   
   #create dtype(enum)
   
   create table dtype
   (id varchar(45) not null,
   primary key(id));
   
   insert into dtype(id) values ('widget');
   insert into dtype(id) values ('youtube');
   insert into dtype(id) values ('image');
   insert into dtype(id) values ('heading');
   insert into dtype(id) values ('html');
   
   #create widget
   
   create table widget
   (id integer(11) not null,
   primary key(id),
   page_id integer(11) not null,
   foreign key(page_id) references `page`(id) on delete cascade on update cascade,
   dtype varchar(45) not null,
   foreign key(dtype) references dtype(id),
   `name` varchar(45),
   width integer(11),
   height integer(11),
   css_class varchar(45),
   css_style varchar(45),
   `text` varchar(45),
   `order` integer(11),
   url varchar(45),
   shareble boolean,
   expandable boolean,
   src varchar(45),
   size integer(11) default 2,
   html varchar(45));
   
   
   #create address
   
   create table address
   (id integer(11) not null auto_increment,
   primary key(id),
    person_id integer(11) not null,
    foreign key(person_id) references person(id) on delete cascade on update cascade,
    street1 varchar(45),
    street2 varchar(45),
    city varchar(45),
    state varchar(45),
    zip varchar(45),
    `primary` boolean);
    
    
    #create phone
    
    create table phone
    (id integer(11) not null auto_increment,
    primary key(id),
    person_id integer(11) not null,
    foreign key(person_id) references person(id) on delete cascade on update cascade,
    phone varchar(45),
    `primary` boolean);
    
    
    #create role(enum)
    
   create table role
   (id varchar(45) not null,
   primary key(id));
   
   insert into role(id) values ('owner');
   insert into role(id) values ('admin');
   insert into role(id) values ('writer');
   insert into role(id) values ('editor');
   insert into role(id) values ('reviewer');
   
   
    #create website_role

    create table website_role
    (id integer(11) not null auto_increment,
    primary key(id),
    developer_id integer(11) not null,
    foreign key(developer_id) references developer(id),
    web_id integer(11) not null,
    foreign key(web_id) references website(id),
    role varchar(45),
    foreign key(role) references role(id));
    
    
    #create priviledge(enum)
    
   create table priviledge
   (id varchar(45) not null,
   primary key(id));
   
   insert into priviledge(id) values ('create');
   insert into priviledge(id) values ('read');
   insert into priviledge(id) values ('update');
   insert into priviledge(id) values ('delete');
    
    
    #create website_priviledge
   
    create table website_priviledge
    (id integer(11) not null auto_increment,
    primary key(id),
    developer_id integer(11) not null,
    foreign key(developer_id) references developer(id),
    web_id integer(11) not null,
    foreign key(web_id) references website(id),
    priviledge varchar(45),
    foreign key(priviledge) references priviledge(id));
    
    
    #create page_role
    
    create table page_role
    (id integer(11) not null auto_increment,
    primary key(id),
    developer_id integer(11) not null,
    foreign key(developer_id) references developer(id),
    page_id integer(11) not null,
    foreign key(page_id) references `page`(id),
    role varchar(45),
    foreign key(role) references role(id));
    
    
    #create page_priviledge
    
    create table page_priviledge
    (id integer(11) not null auto_increment,
    primary key(id),
    developer_id integer(11) not null,
    foreign key(developer_id) references developer(id),
    page_id integer(11) not null,
    foreign key(page_id) references `page`(id),
    priviledge varchar(45),
    foreign key(priviledge) references priviledge(id));
