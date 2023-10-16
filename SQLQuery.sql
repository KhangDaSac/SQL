--TUẦN 1
--BÀI 1: QUẢN LÍ SÁCH
CREATE DATABASE QLSach
ON PRIMARY
(NAME = QLSach_data,
FILENAME = 'D:\SQLSever\tuan01\QLSach_Data.mdf',
SIZE = 20MB,
MAXSIZE = 40MB,
FILEGROWTH = 1MB)
LOG ON
(NAME = QLSach_Log,
FILENAME = 'D:\SQLSever\tuan01\QLSach_Log.ldf',
SIZE = 6MB,
MAXSIZE = 8MB,
FILEGROWTH = 1MB)


exec sp_helpdb QLSach
create database QLGD
on primary
(name = QLGD_data,
filename = 'D:\SQLSever\tuan01\QLGD_data.mdf',
size = 20MB,
maxsize = 40MB,
filegrowth = 1MB
)
log on
(name = QLGD_Log,
filename = 'D:\SQLSever\tuan01\QLGD_Log.ldf',
size = 6MB,
maxsize = 8MB,
filegrowth = 1MB)

alter database QLGD
add filegroup DuLieuGD

alter database QLGD
add file 
(name = QLGD_data2,
filename = 'D:\SQLSever\tuan01\QLGD_data.ndf',
size = 10MB,
maxsize = 20MB,
filegrowth = 2MB)
to filegroup DuLieuGD

ALTER DATABASE QLSach
ADD FILEGROUP DuLieuSach

ALTER DATABASE QLSach
ADD FILE (NAME = QLSach_data2,
FILENAME = 'D:\SQLSever\tuan01\QlSach_Data2.ndf',
Size = 3MB, MaxSize = 5MB, FileGrowth = 1MB) TO FileGroup DuLieuSach

ALTER DATABASE QLSach
SET READ_ONLY

ALTER DATABASE QLSach
SET READ_WRITE


--BÀI 2: QUẢN LÝ BÁN HÀNG
CREATE DATABASE QLBH
ON PRIMARY
(Name = QLBH_data1,
FileName = 'D:\SQLSever\tuan01\QLBH_data1.mdf',
Size = 10MB,
MaxSize = 100MB,
FileGrowth = 1Mb)
LOG ON
(Name = QLBH_Log,
FileName = 'D:\SQLSever\tuan01\QLBH.ldf',
Size = 6MB,
MaxSize = 12MB,
FileGrowth = 1MB)

exec sp_helpdb
exec sp_spaceused
exec sp_helpfile

ALTER DATABASE QLBH
ADD FILEGROUP DuLieuQLBH

ALTER DATABASE QLBH
ADD FILE(NAME = QLBH_data2,
FILENAME = 'D:\SQLSever\tuan01\QLBH_data2.ndf',
SIZE = 3MB,
MAXSIZE = 5MB,
FILEGROWTH = 1MB) TO FILEGROUP DuLieuQLBH

exec sp_helpfilegroup

ALTER DATABASE QLBH
SET READ_ONLY

exec sp_helpdb

ALTER DATABASE QLBH
SET READ_WRITE

ALTER DATABASE QLBH
MODIFY FILE (NAME = QLBH_data1, SIZE = 50MB)

ALTER DATABASE QLBH
MODIFY FILE (NAME = QLBH_log, SIZE = 10MB)


exec sp_addtype MAVUNG, 'char(10)', 'NOT NULL'
exec sp_addtype STT, 'SMALLINT', 'NOT NULL'
exec sp_addtype SodienThoai, 'char(13)', 'NULL'
exec sp_addtype ShortString, 'char(15)', 'NOT NULL'

SELECT domain_name, data_type, character_maximum_length
FROM information_schema.domains
ORDER BY domain_name

USE QLBH
GO 
CREATE TABLE ThongTinKH
(	MaKH STT primary key,
	Vung MAVUNG,
	DiaChi ShortString,
	SoDienThoai SodienThoai,
)

DROP TABLE ThongTinKH

exec sp_droptype SodienThoai

--TUẦN 2

--BAI 1: QUAN LY BAN HANG
create database qlbh
on primary (
name = qlbh_data,
filename = 'D:\SQLSever\tuan02\qlbh_data.mdf',
size = 10mb,
maxsize = 20mb,
filegrowth = 1mb)
log on(
name = qlbh_log,
filename = 'D:\SQLSever\tuan02\qlbh_log.ldf',
size = 10mb,
maxsize = 20mb,
filegrowth = 1mb)

use qlbh

create table NhomSanPham
(manhom Int not null primary key,
tennhom Nvarchar(15))

create table SanPham
( Masp int not null primary key,
Tensp nvarchar(15) not null,
MaNCC int,
MoTa nvarchar(50),
MaNhom int references NhomSanPham(manhom),
DonViTinh nvarchar(20),
GiaGoc Money Check (GiaGoc > 0),
SLTon int check (SLTon >=0)
)

create table HoaDon
(MaHD int not null primary key,
NgayLapHD DateTime default Getdate() Check(NgayLapHD <= GETDATE()),
NgayGiao DateTime,
Noichuyen Nvarchar(60) not null,
MaKH char(5))

create table CT_HoaDon
(MaHD int not null references HoaDon(MaHD),
MaSP int not null references SanPham(MaSP),
SoLuong Smallint check (SoLuong > 0),
DonGia Money,
ChietKhau Money Check (ChietKhau >= 0),
primary key( MaHD, MaSP))

create table NhaCungCap
( MaNCC int not null primary key,
TenNCC nvarchar(40) not null,
Diachi nvarchar(60),
Phone nvarchar(24),
Sofax nvarchar(24),
DCMail nvarchar(50))

create table KhachHang(
MaKH char(5) not null Primary key,
TenKH nvarchar(40) not null,
LoaiKH nvarchar(3) check(LoaiKH in ('VIP','TV', 'VL')),
DiaChi nvarchar(60),
Phone nvarchar(24),
DCMail nvarchar(50),
DiemTL int Check(DiemTL >=0))

alter table HoaDon with check
add constraint fk_hd foreign key (MaKH) references KhachHang(MaKH)

alter table SanPham with check
add constraint fk_sp foreign key (MaNCC) references NhaCungCap(MaNCC)

alter table HoaDon
add LoaiHD char(1) default 'N' check(LoaiHD in ('N','X', 'C','T'))

alter table HoaDon
add constraint ck_hd check(NgayGiao >= NgayLapHD)

--BAI 2: MOVIES

create database movies
on primary
(Name = Movies_data,
Filename = 'D:\SQLSever\Tuan02\Movies_data.mdf',
Size = 25 MB, Maxsize = 40 MB, FileGrowth = 1 MB
)
log on
(Name = Movies_log, 
Filename = 'D:\SQLSever\Tuan02\Movies_log.ldf', 
Size = 6 MB, Maxsize = 8 MB, FileGrowth = 1 MB)

alter database movies
add file (Name =Movies_data2,
Filename ='D:\SQLSever\Tuan02\Movies_data2.ndf',
SIZE =6 MB,
Maxsize =8MB,
FileGrowth = 1 MB)

alter database movies
set single_user

alter database movies
set restricted_user

alter database movies
set multi_user

sp_helpdb

alter database movies
modify file(name = Movies_data2, size = 15MB)

alter database movies
set AUTO_SHRINK on

alter database movies
add filegroup DataGroup

alter database movies
modify file(name = Movies_log, size = 10MB)

alter database movies
modify file(name = Movies_data2, size = 20MB)

alter database movies
add file (Name =Movies_data3,
Filename ='D:\SQLSever\Tuan02\Movies_data3.ndf',
SIZE =6 MB,
Maxsize =8MB,
FileGrowth = 1 MB) to filegroup DataGroup

exec sp_helpdb

exec sp_addtype Movie_num, 'Int', 'not null'
exec sp_addtype Category_num, 'Int', 'not null'
exec sp_addtype Cust_num, 'Int', 'not null'
exec sp_addtype Invoice_num, 'Int', 'not null'

use movies

exec sp_help

create table Customer (
Cust_num Cust_num IDENTITY(300,1) NOT NULL,
Lname Varchar(20) NOT NULL,
Fname varchar(20) NOT NULL,
Address1 varchar(30),
Address2 varchar(20),
City varchar(20),
State Char(2),
Zip Char(10),
Phone varchar(10) not null,
Join_date Smalldatetime not null
)

create table Category (
Category_num Category_num not null,
Description varchar(20) not null
)

create table Movie (
Movie_num Movie_num not null,
Title Cust_num not null,
Category_num Category_num not null,
Date_purch Smalldatetime,
Rental_price Int not null,
Rating Smalldatetime not null
)

create table Rental (
Invoice_num Invoice_num not null,
Cust_num Cust_num not null,
Rental_date smalldatetime not null,
Due_date smalldatetime not null
)

create table Rental_Detail (
Invoice_num Invoice_num not null,
Line_num int not null,
Movie_num Movie_num not null,
Rental_price smallmoney not null
)

alter table Movie
add constraint PK_movie primary key (Movie_num)

alter table Customer
add constraint PK_Customer primary key (Cust_num)

alter table Category
add constraint PK_category primary key (Category_num)

alter table Rental
add constraint PK_rental primary key (Invoice_num)

alter table Movie
add constraint FK_movie foreign key (Category_num) references Category(Category_num)

alter table Rental
add constraint FK_rental foreign key (Cust_num) references Customer(Cust_num)

alter table Rental_detail
add constraint FK_detail_invoice foreign key (Invoice_num) references Rental(Invoice_num) on delete Cascade

alter table Rental_detail
add constraint PK_detail_movie foreign key (Movie_num) references Movie(Movie_num)

alter table Movie
add constraint DK_movie_date_purch Default Getdate() for Date_purch

alter table Customer
add constraint DK_customer_join_date Default Getdate() for join_date

alter table Rental
add constraint DK_rental_rental_date Default Getdate() for Rental_date

alter table Rental
add constraint DK_rental_due_date Default (Getdate() + 2) for Due_date

alter table Movie
add constraint CK_movie check (Rating in ('G', 'PG', 'R', 'NC17', 'NR'))

alter table Rental
add constraint CK_Due_date check (Due_date >= Rental_date)

--BAI 3: DU AN

create database QLDuAn
on primary
(name = QLduan_data,
filename = 'D:\SQLSever\Tuan02\QLDuAn.mdf'
)
log on
( name = QLduan_log,
filename = 'D:\SQLSever\Tuan02\QLDuAn.ldf')

create table NhanVien 
( MaNV Char(10) primary key,
HoTen Char(10),
Phai Char(10),
NgaySinh Char(10),
MaPB Char(10),
NhomTruong int)

create table PhongBan (
MaPB char(10) primary key,
TenPB char(10),
MaTruongPhong char(10)
)

create table NhanVien_DuAn (
MaDA char(10),
MaNV char(10),
MaCV char(10),
ThoiGian char(10)
)

create table CongViec (
MaCV char(10) primary key,
TenCV char(10))

create table DuAn (
MaDA char(10) primary key,
TenDA Char(10))

--TUẦN 3

Use qlbh


alter table NhomSanPham alter column tennhom nvarchar(20)

insert NhomSanPham
values (1, N'Điện Tử'),
(2, N'Gia Dụng'),
(3, N'Dụng Cụ Gia Đình'),
(4, N'Các Mặt Hàng Khác')

insert NhaCungCap 
values (1, N'Công Ty TNHH Nam Phương', N'1 Lê Lợi Phường 4 Gò Vấp', '083843456', '32343434', 'NamPhuong@yahoo.com'),
(2, N'Công Ty Lan Ngọc', N'12 Cao Bá Quát Quận 1 TPHCM', '086234567', '83434355', 'LanNgoc@gmil.com')

insert SanPham
values (1, N'Máy Tính', 1, N'Máy Sony Ram 2GB', 1,  N'Cái', 7000, 100),
(2, N'Bàn Phím', 1, N'Bàn Phím 101 Phím', 1,  N'Cái', 1000, 50),
(3, N'Chuột', 1, N'Chuột Không Dây', 1,  N'Cái', 8000, 150),
(4, N'CPU', 1, N'CPU', 1,  N'Cái', 3000, 200),
(5, N'USB', 1, N'8GB', 1,  N'Cái', 5000, 100),
(6, N'Lò Vi Sóng', 2, null, 3,  N'Cái', 1000000, 20)	

insert KhachHang
values ('KH1', N'Nguyễn Thu Hằng','VL', N'12 Nguyễn Du', '', null, null),
('KH2', N'Lê Minh', 'TV', N'34 Điện Biên Phủ', '0123943655', 'LeMinh@yhoo.com', 100),
('KH3', N'Nguyễn Minh Trung', 'VIP',  N'3 Lê Lợi Quận Gò Vấp', '098343434', 'Trung@gmail.com', 800)

insert HoaDon
values (1, 2015-09-30, 2015-10-5, N'Cửa Hàng ABC 3 Lý Chính Tông Quận 3', 'KH1', null),
(2, 2015-07-29, 2015-08-10, N'23 Lê Lợi Quận Gò Vấp', 'KH2', null),
(3, 2015-10-01, 2015-10-01, N'2 Nguyễn Du Quận Gò Vấp', 'KH3', null)

insert CT_HoaDon
values (1, 1, 5, 8000, null),
(1, 2, 4, 1200, null),
(1, 3, 15, 1000, null),
(2, 2, 9, 1200, null),
(2, 4, 5, 800, null),
(3, 2, 20, 3500, null),
(3, 3, 15, 1000, null)

update SanPham
set GiaGoc = GiaGoc*1.05 where MaSP = 2

update SanPham
set SLTon = 100 where (MaNhom = 3 and MaNCC = 2)

update SanPham
set MoTa = N'1 Cái Lò Vi Sóng' where TenSP = N'Lò Vi Sóng'

update HoaDon
set MaKH= null where MaKH = 'KH3'

update KhachHang
set MaKH = 'VI003' where MaKH = 'KH3'

update HoaDon
set MaKH= null where MaKH = 'KH1'

update KhachHang
set MaKH = 'VL001' where MaKH = 'KH1'

update HoaDon
set MaKH= null where MaKH = 'KH2'

update KhachHang
set MaKH = 'T0002' where MaKH = 'KH2'



delete NhomSanPham
where MaNhom = 4

delete CT_HoaDon
where MaHD = 1 and MaSP = 3

delete CT_HoaDon
where MaHD = 1

delete HoaDon
where MaHD = 2

ALTER TABLE CT_HoaDon
ADD CONSTRAINT FK_CT_HoaDon_HoaDon
FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD)
ON DELETE CASCADE;



