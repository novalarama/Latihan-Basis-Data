-- membuat database dengan nama noval_RPL_29
create database noval_RPL_29;
create table siswa (
    NIS varchar (100),
    Nama varchar (200),
    id_kelas varchar (10),
    primary key(NIS)
);
create table kelas (
    Kode_kelas varchar (20),
    Nama_kelas varchar (50),
    primary key (Kode_kelas)
);
create table mapel(
    Kode_mapel varchar (20),
    Nama_mapel varchar (200),
    primary key (Kode_mapel)
);
create table guru(
    id_guru varchar (20),
    Nama_guru varchar (300),
    primary key (id_guru)
);
create table kbm(
    Kode_mapel varchar (20),
    Kode_kelas varchar (20),
    id_guru varchar (20)
);
create table nilai(
    NIS varchar (20),
    Kode_mapel varchar (20),
    id_guru varchar (20),
    Nilai double
);
-- untuk menambah kolom
alter table mapel
add kkm double;
-- untuk merubah nama kolom
alter table siswa
change id_kelas kode_kelas varchar (20);
-- menghapus kolom id_guru pada tabel nilai
alter table nilai
drop id_guru;
-- membuat query untuk mengisi tabel siswa
insert into siswa values
("111","Ana Putri","XR2"),
("112","Annisa Rachmawati","XR2"),
("113","Alipah Nurhidayati","XR1"),
("114","Aguwin Ardi Pranata","XR1"),
("115","Abdul Widodo","XR3"),
("116","Darmo Joyo","XR3"),
("117","Rosidatul Maghfiroh","XR4"),
("118","Salwatul","XR4"),
("119","Widya Yunitha","XR5"),
("120","Yudhawan Anis","XR5");
-- mengisi tabel kelas
insert into kelas values
("XR1","X RPL 1"),
("XR2","X RPL 2"),
("XR3","X RPL 3"),
("XR4","X RPL 4"),
("XR5","X RPL 5");
-- mengisi table mapel
insert into mapel values
("BIG","Bahasa Inggris",80),
("BIN","Bahasa Indonesia",80),
("KIM","Kimia",70),
("MTK","Matematika",75),
("PKN","Pendidikan Kewarganegaraan",75),
("SI","Sejarah Indonesia",78);
--mengisi tabel guru
insert into guru values
("001","Shelvy Fitria"),
("002","Siti Kurniawati"),
("003","Ukhty Aulia");
-- mengisi tabel kbm
insert into kbm values
("KIM","XR4","002"),
("MTK","XR4","001"),
("MTK","XR3","001"),
("MTK","XR2","001"),
("MTK","XR1","001"),
("MTK","XR5","001"),
("BIN","XR5","003"),
("BIN","XR4","003"),
("BIG","XR5","003"),
("SI","XR4","001"),
("SI","XR5","001"),
("KIM","XR1","002"),
("KIM","XR2","002");
-- mengisi tabel nilai
insert into nilai values
("111","KIM",90),
("112","KIM",60),
("113","KIM",60),
("114","KIM",75),
("113","MTK",85),
("114","MTK",70),
("115","MTK",76),
("118","MTK",80),
("120","MTK",98),
("111","MTK",76),
("111","SI",90),
("112","SI",75),
("112","BIN",60),
("111","BIN",70),
("117","BIN",70);
-- case menampilkan data kelas yang mengikuti Mapel Kimia
select Kelas.Kode_kelas, kelas.Nama_kelas, mapel.Nama_mapel from kelas join kbm
on kelas.Kode_kelas = kbm.Kode_kelas -- mengaitkan kelas ke kbm
inner join mapel 
on kbm.Kode_mapel = mapel.Kode_mapel -- mengaitkan kbm ke mapel
where mapel.Nama_mapel = "Kimia";
-- case menampilkan daftar nama siswa nilai <kkm mtk
select siswa.NIS, siswa.Nama, mapel.Nama_mapel, mapel.kkm, nilai.Nilai  from siswa join nilai
on siswa.NIS = nilai.NIS
inner join mapel
on nilai.Kode_mapel = mapel.Kode_mapel
where Nilai.Nilai < mapel.kkm and mapel.Nama_mapel = "Matematika";
--case menampilkan jumlah siswa yang nilainya dibawah kkm pada setiap mapel
select mapel.Kode_mapel, mapel.Nama_mapel, count(nilai.NIS) as jumlah, min(nilai.Nilai) as nilai_terendah from mapel join nilai
on mapel.Kode_mapel = nilai.Kode_mapel
where nilai.Nilai < mapel.kkm
group by mapel.Kode_mapel;
-- case menampilkan data nilai "Ana Putri" pada setiap mapel
select mapel.Kode_mapel, mapel.Nama_mapel, nilai.nilai from nilai join siswa
on nilai.NIS = siswa.NIS
inner join mapel
on nilai.Kode_mapel = mapel.Kode_mapel
where siswa.Nama = "Ana Putri"
group by mapel.Kode_mapel;
-- case menampilkan daftar nama siswa yang diajar oleh "Siti Kurniawati"
select siswa.NIS, siswa.Nama, kelas.Nama_kelas from siswa join kelas
on siswa.Kode_kelas = kelas.Kode_kelas
inner join kbm
on kbm.Kode_kelas = kelas.Kode_kelas
inner join guru
on guru.id_guru = kbm.id_guru
where guru.Nama_guru = "Siti Kurniawati";
-- case menampilkan nilai rata-rata dari setiap mapel
select mapel.Kode_mapel, mapel.Nama_mapel, avg(nilai.Nilai) as rata_rata from mapel join nilai
on mapel.Kode_mapel = nilai.Kode_mapel
group by mapel.Kode_mapel;