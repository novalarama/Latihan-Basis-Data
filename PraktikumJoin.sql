use praktikum;
-- Nomor 1 : eskplisit
select distinct mahasiswa.NIM, mahasiswa.Nama from mahasiswa join ambil_mk
on mahasiswa.NIM = ambil_mk.NIM
inner join matakuliah
on ambil_mk.Kode_MK = matakuliah.Kode_MK
order by mahasiswa.NIM;
-- nomor ! : implisit
select distinct mahasiswa.NIM, mahasiswa.Nama from mahasiswa,ambil_mk,matakuliah
where mahasiswa.NIM = ambil_mk.NIM and ambil_mk.Kode_MK = matakuliah.Kode_MK
order by mahasiswa.NIM;

--nomor 2
select m.JK, count(m.JK) as Jumlah from mahasiswa m
    -> left outer join ambil_mk a
    -> on m.NIM = a.NIM
    -> where a.NIM is null
    -> group by m.JK;

--nomor 3 : Eksplisit
select m.NIM, m.Nama, a.Kode_MK, k.Nama_MK from mahasiswa m join ambil_mk a
    -> on m.NIM = a.NIM
    -> inner join matakuliah k
    -> on a.Kode_MK = k.Kode_MK
    -> order by m.NIM;
--nomor 3 : Implisit
select m.NIM, m.Nama, a.Kode_MK, k.Nama_MK from mahasiswa m, ambil_mk a, matakuliah k
    -> where m.NIM = a.NIM and a.Kode_MK = k.Kode_MK
    -> order by m.NIM;

--nomor 4
select m.NIM, m.Nama, sum(k.SKS) as Total_SKS from mahasiswa m, ambil_mk a, matakuliah k
    -> where m.NIM = a.NIM and a.Kode_MK = k.Kode_MK
    -> group by m.NIM
    -> having sum(SKS) > 4 and sum(SKS) < 10;
--nomor 5
select k.Kode_MK, k.Nama_MK, k.SKS, k.Semester from mahasiswa m left outer join ambil_mk a
    -> on m.NIM = a.NIM
    -> right outer join matakuliah k
    -> on a.Kode_MK = k.Kode_MK
    -> where m.Nama is null;

--Tugas Rumah
-- Nomor 1
create table instruktur(
    -> NIP int (10),
    -> Nama_instruktur varchar (100) not null,
    -> Jurusan varchar (100) not null,
    -> Asalkota varchar (100) not null,
    -> primary key (NIP));
create table matakuliah2 (
    NO_MK varchar (50) not null,
    -> Nama_MK varchar (100) not null,
    -> SKS int (10) not null,
    -> primary key (NO_MK));
create table kuliah(
    -> NIP int (10) not null,
    -> NO_MK varchar (100) not null,
    -> Ruangan int (100) not null,
    -> Jumlah_mahasiswa int (100) not null);

insert into instruktur values
(1,"Steve Wozniak", "Ilmu Komputer", "Bantul"),
(2,"Steve Jobs", "Seni Rupa", "Solo"),
(3,"James Gosling","Ilmu Komputer","Klaten"),
(4,"Bill Gates","Ilmu Komputer","Magelang");
insert into matakuliah2 values
("KOM101","Algoritma dan Pemrograman",3),
("KOM102","Basis Data",3),
("KOM201","Pemrograman Berorientasi Objek",3),
("SR101","Desain Elementer",3);
insert into kuliah values
(1,"KOM101",101,50),
(1,"KOM102",102,35),
(2,"SR101",101,45),
(3,"KOM201",101,55);
-- nomor 1 - a
select m.NO_MK, m.Nama_MK from matakuliah2 m join kuliah k
on m.NO_MK = k.NO_MK
where Jumlah_mahasiswa > 40
order by m.NO_MK;
-- nomor 1 - b
select i.NIP, i.Nama_instruktur from instruktur i join kuliah k
on i.NIP = k.NIP
inner join matakuliah2 m
on k.NO_MK = m.NO_MK
where m.Nama_MK like "%Basis%"
order by m.NO_MK;
-- nomor 1 - c
select i.NIP, i.Nama_instruktur, sum(k.Jumlah_mahasiswa) as Total_mahasiswa from instruktur i join kuliah k
on i.NIP = k.NIP
where k.NIP = 1;

--Nomor 2
create table customer(
Customer_ID varchar (100) not null,
Customer_name varchar (100) not null,
Customer_address varchar (100) not null,
primary key (Customer_ID));

create table orders(
Order_ID int (10) not null,
Order_date date not null,
Customer_ID varchar (100) not null,
Quantity int (10) not null,
Amount int (20) not null,
primary key (Order_ID));

insert into customer values
("CS001","Adiba","Pandaan"),
("CS002","Erwina","Sidoarjo"),
("CS003","Annas","Blitar"),
("CS004","Galuh","Malang"),
("CS005","Dewi","Tulungagung");

insert into orders values
(0001,'2015-04-01',"CS001",2,40000),
(0002,'2015-04-08',"CS003",3,50000),
(0003,'2015-04-14',"CS005",1,60000);

select Customer_ID, Customer_name from customer
union
select Order_ID, Order_date, Quantity, Amount from orders;

select c.Customer_ID, c.Customer_name, o.Order_ID, o.Order_date, o.Quantity, o.Amount from customer c left outer join orders o
on c.Customer_ID = o.Customer_ID
union
select c.Customer_ID, c.Customer_name, o.Order_ID, o.Order_date, o.Quantity, o.Amount from customer c right outer join orders o
on c.Customer_ID = o.Customer_ID
where o.Customer_ID is null;