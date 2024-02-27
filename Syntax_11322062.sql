/*
   Nama  : Monica Silaban
   NIM   : 11322062
   Kelas : D3 TI 02
*/

/*3.(a) Pembuatan basisdata beserta tabel-tabelnya
    (b)	Menerapkan jenis-jenis Constraint
*/

DROP DATABASE IF EXISTS monika;
CREATE DATABASE `monika`;
USE `monika`;

-- Tabel admin --
CREATE TABLE `admin` (
  `id` BIGINT(20) UNSIGNED NOT NULL,
  `nama` VARCHAR(255) NOT NULL,
  `alamat` VARCHAR(255) NOT NULL,
  `username` VARCHAR(255) NOT NULL,
  `nomorhp` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;


-- Tabel petani --
CREATE TABLE `petani` (
  `id` BIGINT(20) UNSIGNED NOT NULL,
  `nama` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nomorhp` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_unique` (`username`),
  UNIQUE KEY `email_unique` (`email`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Tabel edukasi
CREATE TABLE `edukasi` (
  `id` BIGINT(20) UNSIGNED NOT NULL,
  `judul` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gambar` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `admin_id` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Tabel barang
CREATE TABLE `barang` (
  `id` BIGINT(20) UNSIGNED NOT NULL,
  `nama` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gambar` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `admin_id` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_barang_admin`
    FOREIGN KEY (`admin_id`)
    REFERENCES `admin` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `uniq_nama_admin` UNIQUE (`nama`, `admin_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Tabel peminjaman
CREATE TABLE `peminjaman` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `namaalat` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_peminjaman` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal_pemulangan` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notif` VARCHAR(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pemberitahuan` LONGTEXT COLLATE utf8mb4_unicode_ci,
  `admin_id` BIGINT(20) UNSIGNED NOT NULL,
  `petani_id` BIGINT(20) UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_peminjaman_admin`
    FOREIGN KEY (`admin_id`)
    REFERENCES `admin` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT
    FOREIGN KEY (`petani_id`)
    REFERENCES `petani` (`id`)
    ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Tabel proyek_tani
CREATE TABLE `proyek_tani` (
  `id` BIGINT(20) UNSIGNED NOT NULL,
  `judul` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gambar` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` LONGTEXT COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_id` BIGINT(20) UNSIGNED NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_proyek_tani_admin`
    FOREIGN KEY (`admin_id`)
    REFERENCES `admin` (`id`)
    ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Tabel migrations --
CREATE TABLE `migrations` (
  `id` INT(10) UNSIGNED NOT NULL,
  `migration` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- tabel pivot "petani_edukasi"
CREATE TABLE `petani_edukasi` (
  `petani_id` BIGINT(20) UNSIGNED NOT NULL,
  `edukasi_id`BIGINT(20) UNSIGNED NOT NULL,
  CONSTRAINT PRIMARY KEY (`petani_id`, `edukasi_id`),
  CONSTRAINT FOREIGN KEY (`petani_id`) REFERENCES `petani` (`id`) ON DELETE CASCADE,
  CONSTRAINT FOREIGN KEY (`edukasi_id`) REFERENCES `edukasi` (`id`) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
SELECT * FROM petani_edukasi;


-- tabel pivot "petani_barang"
CREATE TABLE `petani_barang` (
  `petani_id` BIGINT(20) UNSIGNED NOT NULL,
  `barang_id` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`petani_id`, `barang_id`),
  CONSTRAINT `fk_petani_barang_petani` FOREIGN KEY (`petani_id`) REFERENCES `petani` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_petani_barang_barang` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`) ON DELETE CASCADE
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- Tabel pivot "petani_proyek"
CREATE TABLE `petani_proyek` (
  `petani_id` BIGINT(20) UNSIGNED NOT NULL,
  `proyek_id` BIGINT(20) UNSIGNED NOT NULL,
  FOREIGN KEY (`petani_id`) REFERENCES `petani` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`proyek_id`) REFERENCES `proyek_tani` (`id`) ON DELETE CASCADE,
  CONSTRAINT PRIMARY KEY (`petani_id`, `proyek_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


/* 4.(a) melakukan pengisian data dummy pada basisdata */

-- data dummy tabel admin --
INSERT INTO `admin` (`id`, `nama`, `alamat`, `username`, `nomorhp`, `email`, `password`) VALUES
(1, 'admin', 'jl.ahbs', 'admin01', '08287262423', 'admin01@gmail.com', '333fdg'),
(2, 'admin2', 'jl.sdgs', 'admin02', '08923284834', 'admin02@gmail.com', 'auhsc'),
(3, 'admin3', 'jl.aaid', 'admin03', '082324343482', 'admin03@gmail.com', 'sahb'),
(4, 'admin4', 'jl.agyasd', 'admin04', '08192844221', 'admin04@gmail.com', 'safaf'),
(5, 'admin5', 'jl.sdgysa', 'admin05', '08787454665', 'admin05@gmail.com', 'aassc'),
(6, 'admin6', 'jl.sadytas', 'admin06', '08754245765', 'admin06@gmail.com', 'aDADCF'),
(7, 'admin7', 'jl.ysahsbs', 'admin07', '082423482411', 'admin07@gmail.com', 'gsdbwasf'),
(8, 'admin8', 'jl.dfssfdas', 'admin08', '0829282483234', 'admin08@gmail.com', 'ssgg'),
(9, 'admin9', 'jl.asda', 'admin09', '086234822742', 'admin09@gmail.com', 'efevfwa'),
(10, 'admin10', 'jl.ajhsadas', 'admin10', '08923242354', 'admin10@gmail.com', 'wgfetgrg');

SELECT * FROM admin;

-- data dummy tabel barang --
INSERT INTO `barang` (`id`, `nama`, `jumlah`, `gambar`, `created_at`, `updated_at`, `admin_id`) VALUES
(1, 'cangkul', '10', 'cangkul.jpeg', NULL, NULL,1),
(2, 'traktor', '10', 'traktor.jpeg', NULL, NULL,3),
(3, 'Garu sisir', '10', 'garu sisir.jpeg', NULL, NULL,2),
(4, 'arit', '10', 'arit.jpeg', NULL, NULL,5),
(5, 'Rotavator', '14', 'rotavator,jpeg', NULL, NULL,4),
(6, 'Bajak Singkal', '11', 'bajaksingkal.jpeg', NULL, NULL,6),
(7, 'Bajak Subsoil', '22', 'bajaksubsoil.jpeg', NULL, NULL,8),
(8, 'Garu Piring', '21', 'garupiring.jpeg', NULL, NULL,10),
(9, 'Pompa Air', '5', 'gambar_pompa_air.jpg', NULL, NULL,2),
(10, 'Mesin Pengolah Tanah', '2', 'gambar_mesin_pengolah.jpg', NULL, NULL,1),
(11, 'Gembor', '20', 'gambar_gembor.jpg', NULL, NULL,1),
(12, 'Sabit', '20', 'sabit.jpg', NULL, NULL,3),
(13, 'Benih', '50', 'gambar7.jpg', NULL, NULL,4),
(14, 'Gerobak', '12', 'gambar8.jpg', NULL, NULL,8),
(15, 'Semburan pestisida', '26', 'semburanpestisida.jpg', NULL, NULL,2),
(16, 'Alat penggiling padi', '17', 'penggiling.jpg', NULL, NULL,6),
(17, 'Mesin pemotong rumput', '4', 'pemotong.jpg', NULL, NULL,10),
(18, 'Alat penanam padi', '7', 'penanam.jpg', NULL, NULL,4),
(19, 'Alat pemipil jagung', '11', 'pemipil.jpg', NULL, NULL,6),
(20, 'Keranjang panen', '32', 'keranjang.jpg', NULL, NULL,7);
SELECT *FROM barang;


-- data dummy tabel migrations --
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_user_table', 1),
(2, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(3, '2023_05_02_065937_create_edukasi_table', 1),
(4, '2023_05_02_065953_create_barang_table', 1),
(5, '2023_05_02_070002_create_peminjaman_table', 1),
(6, '2023_05_02_070014_create_proyek_tani_table', 1);
SELECT *FROM migrations;


-- data dummy tabel edukasi --
INSERT INTO `edukasi` (`id`, `judul`, `gambar`, `deskripsi`, `created_at`, `updated_at`, `admin_id`) VALUES
(1, 'Menanam padi dengan baik', 'menanam.jpeg', 'Menanam padi dengan baik membutuhkan beberapa langkah yang harus diperhatikan sejak awal sampai panen. Berikut ini adalah beberapa hal yang perlu diperhatikan dalam menanam padi dengan baik:\r\n\r\n1.Pemilihan lahan dan persiapan lahan\r\nPilihlah lahan yang memenuhi persyaratan untuk menanam padi, seperti tanah yang subur, drainase yang baik, dan tingkat kelembaban yang sesuai. Setelah itu, lakukan persiapan lahan dengan membersihkan gulma dan memperbaiki struktur tanah.\r\n\r\n2.Pemilihan varietas padi yang tepat\r\nPilihlah varietas padi yang cocok dengan kondisi lahan dan iklim di daerah Anda. Pastikan bahwa benih padi yang digunakan sudah melalui proses seleksi dan bersertifikat.\r\n\r\n3.Penanaman benih padi\r\nBenih padi perlu direndam selama beberapa jam sebelum ditanam untuk mempercepat proses perkecambahan. Kemudian, benih ditanam dengan jarak dan kedalaman yang sesuai.\r\n\r\n4.Pemberian pupuk dan pengairan\r\nPadi membutuhkan pupuk dan pengairan yang cukup untuk tumbuh dengan baik. Pupuk yang diberikan harus disesuaikan dengan kebutuhan tanaman padi dan tidak berlebihan. Pengairan dilakukan secara teratur dan cukup untuk menjaga kelembaban tanah.\r\n\r\n5.Pengendalian hama dan penyakit\r\nPengendalian hama dan penyakit pada tanaman padi perlu dilakukan secara teratur untuk mencegah kerusakan pada tanaman dan hasil panen. Penggunaan pestisida perlu disesuaikan dengan dosis yang tepat dan tidak berlebihan.\r\n\r\n6.Pemeliharaan tanaman padi\r\nPadi perlu dipelihara secara teratur dengan cara melakukan pemangkasan, pembumbunan, dan pembersihan lahan dari gulma. Hal ini dilakukan untuk mencegah penyebaran hama dan penyakit.\r\n\r\n7.Pemanenan\r\nPadi siap dipanen setelah bulirnya sudah menguning dan bonggolnya sudah berisi. Pemanenan dilakukan dengan cara memotong tangkai padi dan kemudian disusun dalam tandan untuk dikeringkan.\r\n\r\nDengan memperhatikan langkah-langkah di atas, Anda dapat menanam padi dengan baik dan memperoleh hasil panen yang optimal. Namun, perlu diingat bahwa menanam padi membutuhkan kesabaran dan perhatian yang baik agar dapat menghasilkan hasil yang maksimal.', NULL, NULL,1),
(2, 'Membedakan bibit padi unggul dan tidak', 'bibit.jpeg', 'Memilih bibit padi yang unggul sangat penting dalam meningkatkan hasil panen dan produktivitas lahan pertanian. Berikut ini adalah beberapa cara untuk membedakan bibit padi yang unggul dan tidak:\r\n\r\n1.Melihat kualitas benih\r\nPilihlah bibit padi yang berkualitas dengan bentuk benih yang baik dan berukuran seragam. Benih yang berkualitas biasanya memiliki warna yang cerah, bersih, dan bebas dari kotoran atau benda asing.\r\n\r\n2.Memeriksa keberadaan sertifikat\r\nPastikan bibit padi yang Anda pilih memiliki sertifikat yang dikeluarkan oleh lembaga yang terkait dengan pertanian, seperti Balai Besar Pengujian Mutu Benih Tanaman Pangan atau Balai Penelitian Tanaman Padi. Sertifikat ini menunjukkan bahwa bibit padi telah lulus uji mutu dan standar yang ditetapkan.\r\n\r\n3.Memperhatikan masa simpan\r\nPastikan bibit padi yang akan digunakan masih dalam masa simpan yang baik. Biasanya, bibit padi dapat disimpan selama satu tahun, namun kualitas benih dapat menurun seiring berjalannya waktu. Pilih bibit padi yang masih dalam masa simpan yang relatif baru dan memiliki kemampuan perkecambahan yang baik.\r\n\r\n4.Memperhatikan varietas padi\r\nPilih varietas padi yang cocok dengan kondisi lahan dan iklim di daerah Anda. Varitas padi yang cocok dapat menghasilkan produksi yang tinggi dan tahan terhadap hama dan penyakit.\r\n\r\n5.Memperhatikan toleransi terhadap stress\r\nPilih bibit padi yang memiliki toleransi yang baik terhadap stress lingkungan seperti kekeringan, kelembaban, dan cuaca ekstrem. Bibit padi yang tahan terhadap stress lingkungan cenderung lebih tahan terhadap hama dan penyakit.\r\n\r\nDengan memperhatikan beberapa hal di atas, Anda dapat membedakan bibit padi yang unggul dan tidak. Penting untuk diingat bahwa pemilihan bibit padi yang tepat merupakan langkah penting dalam meningkatkan produktivitas lahan pertanian dan memperoleh hasil panen yang optimal.', NULL, NULL, 5),
(3, 'masa panen yang baik untuk tumbuhan jagung', 'jagung.jpeg', 'Masa panen yang baik untuk tanaman jagung sangat penting dalam mendapatkan hasil panen yang optimal. Berikut adalah beberapa hal yang perlu diperhatikan saat melakukan panen jagung: \r\n\r\n1.Memperhatikan umur tanaman\r\nWaktu panen jagung sebaiknya dilakukan pada umur tanaman yang tepat. Pada umumnya, jagung siap panen setelah mencapai umur 70-100 hari atau setelah jagung sudah mengeras. Namun, waktu panen juga tergantung pada jenis varietas jagung yang ditanam dan kondisi lahan. \r\n\r\n2.Memeriksa kematangan jagung\r\nSebelum melakukan panen, pastikan jagung sudah matang dengan baik. Ciri-ciri jagung yang sudah matang antara lain daun sudah kering, bulir jagung sudah berwarna kuning kecoklatan, dan biji jagung sudah mengeras. \r\n\r\n3. Memilih waktu panen yang tepat\r\nPanen jagung sebaiknya dilakukan pada pagi atau sore hari, ketika suhu udara lebih rendah dan kelembaban udara lebih tinggi. Hal ini dilakukan untuk mengurangi kerusakan pada jagung akibat panas dan kekeringan. \r\n\r\n4.Menggunakan alat panen yang tepat\r\nAlat panen jagung yang umum digunakan adalah sabit atau gergaji besi. Pastikan alat panen yang digunakan dalam kondisi baik dan tajam untuk memperkecil kerusakan pada jagung. \r\n\r\n5.Menjaga kualitas jagung\r\nSetelah panen, jagung harus segera dipindahkan ke tempat yang aman dan kering untuk menjaga kualitas biji jagung. Jagung yang dibiarkan dalam kondisi lembab dan panas dapat menyebabkan kualitas jagung menurun dan terjadi kerusakan pada biji jagung. \r\n\r\n6.Penyimpanan\r\nSimpan biji jagung dalam wadah yang bersih, kering, dan tertutup rapat. Hindari penyimpanan di tempat yang lembab dan terkena sinar matahari langsung.\r\n\r\nDengan memperhatikan hal-hal di atas, Anda dapat melakukan panen jagung dengan baik dan mendapatkan hasil panen yang optimal. Penting untuk diingat bahwa masa panen yang tepat dan penanganan jagung yang benar sangat penting dalam menjaga kualitas jagung dan menghindari kerusakan yang dapat merugikan petani.', NULL, NULL,3),
(4, 'jumlah panen padi dalam setahun', 'panen.jpeg', 'Jumlah panen padi dalam setahun tergantung pada jenis varietas padi dan kondisi lingkungan tempat padi ditanam. Padi yang ditanam di daerah dengan iklim tropis seperti Indonesia biasanya dapat menghasilkan dua hingga tiga kali panen dalam setahun. Berikut adalah penjelasan lebih detail tentang jumlah panen padi dalam setahun: \r\n\r\n1.Varietas padi yang dapat panen 2 kali dalam setahun\r\nJenis padi yang dapat menghasilkan dua kali panen dalam setahun disebut dengan varietas padi yang berasal dari tipe genetik yang dikenal sebagai varietas padi inbrida. Varietas padi inbrida umumnya lebih produktif dibandingkan dengan varietas padi hibrida. \r\n\r\n2.Varietas padi yang dapat panen 3 kali dalam setahun\r\nJenis padi yang dapat menghasilkan tiga kali panen dalam setahun disebut dengan varietas padi hibrida. Varietas padi hibrida ini dihasilkan dari persilangan antara dua atau lebih varietas padi yang berbeda dan menghasilkan padi yang lebih tahan terhadap hama dan penyakit.  \r\n\r\n3.Perlu diingat bahwa dalam satu musim tanam, hanya varietas padi tertentu yang dapat menghasilkan dua atau tiga kali panen. Selain itu, jumlah panen padi dalam setahun juga dapat dipengaruhi oleh faktor lain seperti kondisi tanah, musim hujan, dan faktor lingkungan lainnya. \r\n\r\nOleh karena itu, penting untuk memilih varietas padi yang tepat sesuai dengan kondisi lahan dan lingkungan di daerah Anda, serta memperhatikan teknik budidaya padi yang tepat seperti pengaturan jadwal tanam dan pemberian pupuk yang cukup untuk mendapatkan hasil panen yang optimal.', NULL, NULL,7),
(5, 'Pentingnya Pemupukan', 'pemupukan.jpeg', 'Pemupukan yang tepat dapat meningkatkan hasil panen dan kualitas produk pertanian. Penting untuk memilih pupuk yang sesuai dengan jenis tanaman dan kondisi tanah yang ada.', NULL, NULL,3),
(6, 'Penggunaan Pestisida yang Aman', 'pestisidaaman.jpeg', 'Pestisida harus digunakan dengan hati-hati dan sesuai dengan dosis yang direkomendasikan untuk menghindari kerusakan pada tanaman dan kesehatan manusia.', NULL, NULL,8),
(7, 'Pengelolaan Air yang Baik', 'air.jpeg', 'Air adalah sumber kehidupan bagi tanaman. Penting untuk mengelola air dengan baik dan memperhatikan irigasi yang tepat agar tanaman dapat tumbuh dengan baik.', NULL, NULL,5),
(8, 'Diversifikasi Tanaman', 'diversifikasi.jpeg', 'Diversifikasi tanaman dapat meningkatkan kesempatan untuk mendapatkan keuntungan yang lebih besar. Selain itu, dapat membantu mengurangi risiko gagal panen karena adanya variasi tanaman yang tumbuh.', NULL, NULL,9),
(9, 'Pemanfaatan Teknologi Pertanian', 'teknologi.jpeg', 'Teknologi pertanian seperti penggunaan mesin, alat dan peralatan modern dapat membantu mempermudah proses pertanian, meningkatkan produktivitas dan efisiensi.', NULL, NULL,3),
(10, 'Kebijakan penggunaan pupuk', 'pupukk.jpeg', 'Penggunaan pupuk secara berlebihan akan berdampak buruk bagi tanaman.', NULL, NULL,1);

SELECT *FROM edukasi;


-- data dummy tabel proyek tani --
INSERT INTO `proyek_tani` (`id`, `judul`, `gambar`, `deskripsi`, `created_at`, `updated_at`, `admin_id`) VALUES
(1, 'Memperbaiki Pengaliran Sawah yang Tersumbat', 'pengaliran.jpg', 'Sawah yang tersumbat dapat menghambat aliran air dan merusak produktivitas pertanian. Oleh karena itu, proyek tani untuk memperbaiki pengaliran sawah yang tersumbat perlu dilakukan. Berikut adalah langkah-langkah dalam memulai proyek tani tersebut:\r\n\r\n1.Pemantauan dan Analisis Pengaliran\r\nLangkah pertama dalam proyek ini adalah melakukan pemantauan dan analisis pengaliran air di sawah. Hal ini meliputi identifikasi titik-titik yang tersumbat dan penyebabnya. Misalnya, tersumbatnya aliran air karena material yang terseret atau tumbuhan yang tumbuh di saluran air. Selain itu, juga dilakukan analisis untuk menentukan kualitas air yang mengalir di saluran tersebut.\r\n\r\n2.Perencanaan Konstruksi Saluran Air\r\nSetelah pemantauan dan analisis dilakukan, dilakukan perencanaan konstruksi saluran air yang baru. Konstruksi harus dirancang agar dapat mengalirkan air dengan baik dan tidak mudah tersumbat. Hal ini meliputi pemilihan bahan konstruksi yang sesuai dengan kondisi lingkungan dan kebutuhan air yang ada.\r\n\r\n3.Pembersihan Saluran Air\r\nSetelah perencanaan selesai, dilakukan pembersihan saluran air yang tersumbat. Pembersihan dapat dilakukan dengan menggunakan alat berat atau secara manual. Material yang terseret seperti lumpur dan batu-batu kecil harus dibersihkan agar tidak menyumbat aliran air. Tumbuhan yang tumbuh di sekitar saluran air juga harus dipangkas agar tidak merusak saluran air.\r\n\r\n4.Pengujian Saluran Air\r\nSetelah saluran air selesai dibangun, dilakukan pengujian untuk memastikan bahwa saluran air berfungsi dengan baik dan tidak ada kebocoran. Pengujian juga dilakukan untuk memastikan kualitas air yang mengalir sesuai dengan standar kualitas air untuk pertanian.\r\n\r\n5.Perawatan dan Pemeliharaan\r\nTerakhir, perawatan dan pemeliharaan saluran air harus dilakukan secara rutin agar saluran air tetap berfungsi dengan baik. Hal ini meliputi pembersihan saluran air, perbaikan saluran air yang rusak, serta penggantian pintu air atau pipa yang sudah aus atau bocor.\r\n\r\nProyek tani untuk memperbaiki pengaliran sawah yang tersumbat dapat meningkatkan produktivitas pertanian dan mengurangi risiko banjir di lahan pertanian. Selain itu, proyek tani ini juga dapat meningkatkan efisiensi penggunaan air dan meningkatkan kualitas hasil panen.', NULL, NULL, 1),
(2, 'Petani dapat memulai proyek budidaya sayuran ', 'budidaya.jpeg', 'Petani dapat memulai proyek budidaya sayuran organik dengan menggunakan teknik pertanian ramah lingkungan. Hal ini dapat meningkatkan nilai jual produk dan mengurangi biaya produksi.', NULL, NULL, 2),
(3, 'Pengolahan Kompos', 'kompos.jpeg', 'Petani dapat memulai proyek pengolahan kompos dari limbah pertanian dan organik. Kompos yang dihasilkan dapat digunakan sebagai pupuk alami untuk meningkatkan kualitas tanah dan hasil panen.', NULL, NULL, 3),
(4, 'Budidaya Lebah Madu', 'lebah madu.jpeg', 'Petani dapat memulai proyek budidaya lebah madu untuk memproduksi madu berkualitas tinggi dan meningkatkan produktivitas pertanian. Selain itu, keberadaan lebah juga dapat meningkatkan polinasi dan pertumbuhan tanaman.', NULL, NULL, 4),
(5, 'Pembuatan Pupuk Cair', 'pupuk.jpeg', 'Petani dapat memulai proyek pembuatan pupuk cair dari bahan organik seperti kotoran hewan dan limbah tanaman. Pupuk cair ini dapat digunakan sebagai alternatif pupuk kimia dan meningkatkan kualitas tanah dan hasil panen.', NULL, NULL, 5),
(6, 'Pembibitan Tanaman Unggul', 'tanaman.jpeg', 'Petani dapat memulai proyek pembibitan tanaman unggul seperti tanaman buah, sayuran atau tanaman obat-obatan. Tanaman unggul ini dapat memiliki kualitas yang lebih baik dan menghasilkan panen yang lebih banyak.', NULL, NULL, 7),
(7, 'Pengolahan Hasil Pertanian', 'hasilpertanian.jpeg', 'Petani dapat memulai proyek pengolahan hasil pertanian seperti pengeringan, pengolahan bahan makanan, pengemasan dan penjualan langsung. Hal ini dapat meningkatkan nilai tambah produk dan meningkatkan pendapatan petani.', NULL, NULL, 7),
(8, 'Budidaya Ikan Lele', 'ikanlele.jpeg', 'Petani dapat memulai proyek budidaya ikan lele sebagai usaha tambahan. Budidaya ikan lele relatif mudah dilakukan dan memiliki potensi pasar yang luas.', NULL, NULL, 6),
(9, 'Pengembangan Agrowisata', 'agrowisata.jpeg', 'Petani dapat memulai proyek pengembangan agrowisata di lahan pertanian mereka. Agrowisata dapat menarik wisatawan dan memberikan pengalaman edukatif tentang pertanian kepada pengunjung.', NULL, NULL, 8),
(10, 'Budidaya Jamur Tiram', 'jamur.jpeg', 'Petani dapat memulai proyek budidaya jamur tiram sebagai alternatif usaha pertanian. Budidaya jamur tiram dapat dilakukan dalam skala kecil dan memiliki nilai jual yang baik.', NULL, NULL, 10);

SELECT *FROM proyek_tani;


-- data dummy tabel petani --
INSERT INTO `petani` (`id`, `nama`, `alamat`, `username`, `nomorhp`, `email`, `password`, `level`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'jalan admin', 'admin', '08121345678', 'admin@gmail.com', '$2y$10$CxjDKXPe6b9hKIo9Vxn4ie20Fg28cpFP1opxwP0S5lLuTj9awmOmW', 'admin', '2023-05-03 00:18:35', '2023-05-03 00:18:35'),
(2, 'caca', 'jalan semangka', 'caca', '082123658920', 'caca@gmail.com', '$2y$10$l1jcXjFylyojSaFP64LWweI.5uEKFswQkzn3VydmTA9gJ8UfpfOjO', 'user', '2023-05-03 06:59:28', '2023-05-03 06:59:28'),
(3, 'ii', 'jalan durian', 'ii', '082123656920', 'ii@gmail.com', '$2y$10$0aJ.mirzzImIjrxcW0Y0G.TYDUJT.N5GcnlNKKawuf1/QXnru.NTW', 'user', '2023-05-03 07:03:26', '2023-05-03 07:03:26'),
(4, 'momn', 'jalan anggur', 'momn', '082123376920', 'adinda@gmail.com', '$2y$10$sKp8D21M7crUkd8QH96y9OXg49YIpodwcJiGA9hmkj7ZUKGGn1Llu', 'user', '2023-05-03 07:04:05', '2023-05-03 07:04:05'),
(6, 'monica', 'jalan nenas', 'monica', '082124576920', 'monica@gmail.com', '$2y$10$5POA9SJ6UiOl/wcgd9gqTerWdthLP3aTMCI1muURybv6WiJVNyUcm', 'user', '2023-05-03 07:10:05', '2023-05-03 07:10:05'),
(7, 'Oka', 'Ki. Basmol Raya No. 953, Banjarbaru 57057, Sultra', 'oka.hardiansyah', '(+62) 400 0711 251', 'dipa.suryatmi@example.net', '$2y$10$qZ.tnrge0aQ2UaGH99yAzeFR4gcfXpb5DkGffEOyTt0UHcowWPN3u', 'user', NULL, NULL),
(8, 'Samosir', 'Ki. Laksamana No. 102, Cirebon 99650, Lampung', 'ynovitasari', '0867 6483 765', 'rahimah.adhiarja@example.com', '$2y$10$eOCbOLPRgHF6n.4DuN1x5uMvW8YoZbztPBOwwwmiV3L.9OkhPwY1S', 'user', NULL, NULL),
(9, 'Luwar Dongoran', 'Ki. Baya Kali Bungur No. 569, Lhokseumawe 53574, DIY', 'gwidiastuti', '0383 8789 107', 'faizah71@example.com', '$2y$10$yH0H1ggKTt4/kBA6vBC5o.wzD78JJkBUlXG98NbNy4pW0po5H1oeS', 'user', NULL, NULL),
(10, 'Widiastuti', 'Jln. Lembong No. 466, Banda Aceh 49212, Jatim', 'mnamaga', '0901 1634 161', 'ifa.sirait@example.com', '$2y$10$dn2QeUlJY9/7xc5XiAfXgehzXR/D4YR8YUBht30oGXAPcoMX6k2o6', 'user', NULL, NULL),
(11, 'Puspita S.H.', 'Kpg. Abdullah No. 611, Pekanbaru 17263, Pabar', 'elvina65', '(+62) 991 1673 174', 'victoria80@example.org', '$2y$10$zLtmhvg7Km8r13KFl5W4De1/GkShgsSBfEIe0oKGs0dRnDizl0QY6', 'user', NULL, NULL),
(12, 'Sinaga M.M.', 'Ki. Ekonomi No. 728, Administrasi Jakarta Pusat 66968, Sumbar', 'teddy.kurniawan', '(+62) 830 3498 071', 'lmandasari@example.net', '$2y$10$F9Wq/.26BFmgrwszIArPM.Zqtdv5u4l5MGpTshPmWi.I25CsuZhay', 'user', NULL, NULL),
(13, 'Widiastuti', 'Kpg. Bambu No. 243, Bau-Bau 77853, Banten', 'iyuliarti', '0239 4139 089', 'puwais@example.net', '$2y$10$Eaj9qW/MpjSvaXD.SPkDYOIU.BpR/rotSX5GGfu6ej.G8qq2F.IKe', 'user', NULL, NULL),
(14, 'Wijayanti', 'Psr. Bakau Griya Utama No. 440, Banjarmasin 72296, Babel', 'lwidiastuti', '(+62) 257 3098 8814', 'yardianto@example.org', '$2y$10$XACDAvx2tYRX8TfTuUBwEe131Wmldrk.donyUCa.TilKJvtVn5xRG', 'user', NULL, NULL),
(15, 'Palastri S.H.', 'Jln. Asia Afrika No. 763, Probolinggo 71700, Maluku', 'narji87', '(+62) 288 4343 300', 'imaheswara@example.com', '$2y$10$mIcWpAq8tnNQY/b9IOXyJu7Wl5kZ99GzfqvrF3w4jn2HLgOFCVOey', 'user', NULL, NULL),
(16, 'Waskita', 'Ds. Sudirman No. 545, Palangka Raya 10192, Jateng', 'fsuryatmi', '(+62) 548 7399 1002', 'nnainggolan@example.com', '$2y$10$9hk1la4iylW/a4Ge0TRWH.QisLbRdldRiZZz2Ii3AMv3/uHuVQ2F6', 'user', NULL, NULL),
(17, 'Nuraini', 'Ds. Sumpah Pemuda No. 26, Jambi 95852, DKI', 'puspita.puspa', '0649 6215 5439', 'lailasari.zamira@example.net', '$2y$10$8oPYUL/YAFLKvuiUNIibS.r2DV4vY7v4YgXQOy7ix2aCefr9Gl4F2', 'user', NULL, NULL),
(18, 'Halima Mandasari', 'Jr. S. Parman No. 47, Bandung 42348, Maluku', 'dsafitri', '(+62) 942 6916 148', 'almira.winarsih@example.org', '$2y$10$6R2YuTwjZ4Z/3jLpg6hK..hcUNd0hU4pah/p/JJIyawCHnrigH662', 'user', NULL, NULL),
(19, 'Maida Yolanda S.Kom', 'Ds. Surapati No. 368, Medan 76003, Banten', 'bmahendra', '0930 1176 0813', 'widiastuti.karen@example.org', '$2y$10$BYXGqPFqRNyum6WA2MZRaOujO0c6SdasoYUjIkoVsHz7kL34JsDCS', 'user', NULL, NULL),
(20, 'Zulaika', 'Jln. Raya Ujungberung No. 734, Batu 22915, Aceh', 'ohutagalung', '0573 2855 646', 'gawati56@example.org', '$2y$10$xRpL2xt7m8yuaVTeXW1Px.ATpBopPkQgwUo3UBHZqLTDXm/9i9Yri', 'user', NULL, NULL),
(21, 'Januar', 'Jln. Baik No. 362, Langsa 46258, Riau', 'harimurti88', '0230 2049 0121', 'melani.paramita@example.net', '$2y$10$UCwj6WkhCPNANGetFiUsA.3aemj4m1IXFf4eKbLo2nsRqwWwhKTIq', 'user', NULL, NULL),
(22, 'Budiman', 'Dk. Cemara No. 951, Kupang 96561, Bali', 'diah.siregar', '0984 5627 378', 'fhalimah@example.com', '$2y$10$8BVgNulPQLsXLm/.T1eNo.iim4E78RVn8AR8vvhcg.Ze7hDOvyqU2', 'user', NULL, NULL),
(23, 'Kom', 'Jr. Wahid Hasyim No. 457, Probolinggo 89792, Sulteng', 'siti.halimah', '0826 7918 493', 'mursita.waskita@example.com', '$2y$10$k9La4XjJjy8tVV1W89yeOewHF9R4Wg9RmbTiRPFSupVGiFKDm8Vr.', 'user', NULL, NULL),
(24, 'Situmorang', 'Ds. Abdul Muis No. 559, Tanjungbalai 47330, Sulteng', 'banawi48', '(+62) 775 5788 2043', 'mandala.luwes@example.net', '$2y$10$w1TDXcED9NAAJqY4MamabutqFnWINl9bUfHKf0ULQTFbxWmWEHmcO', 'user', NULL, NULL),
(25, 'Laksmiwati S.T.', 'Jr. Gardujati No. 626, Makassar 54273, DKI', 'putri33', '0221 3417 316', 'lidya.uyainah@example.net', '$2y$10$VFjztFeR0QiuLhfDQcuxneb9AZoczoRBFrIcb.tD3gZW.La6evT2y', 'user', NULL, NULL),
(26, 'Pratiwi', 'Kpg. B.Agam 1 No. 221, Sorong 95681, Jabar', 'nababan.tina', '0860 233 896', 'yolanda.rahayu@example.com', '$2y$10$T7i11gjA2/iNzljD4esefOa6qMTlD4x8GIL8kxXddZsLmlb5O6Qsu', 'user', NULL, NULL);

SELECT *FROM petani;

-- data dummy tabel peminjaman --
INSERT INTO `peminjaman` (`id`, `nama`, `alamat`, `namaalat`, `jumlah`, `tanggal_peminjaman`, `tanggal_pemulangan`, `status`, `notif`, `pemberitahuan`, `created_at`, `updated_at`, `petani_id`, `admin_id`) VALUES
(1, 'Eka', 'Jr. halo No. 685, Tomohon 98025, Kalsel', 'atque', '8', '2023-02-09 21:34:59', '2023-03-16 23:29:29', 'dipinjam', '0', 'Unde quod odio voluptatem. Tenetur reprehenderit aliquid animi atque laudantium. Quod aperiam sed maxime dolores.',  NULL, NULL,1,8),
(2, 'Poo', 'Gg. Baranang Siang Indah No. 827, Tual 32691, Sumsel', 'hic', '1', '2023-03-23 07:57:03', '2023-04-08 14:43:37', 'dipinjam', '1', 'Similique alias perspiciatis sapiente iure. Est ea ut distinctio tenetur reprehenderit. Doloribus enim cum ipsum quaerat.',  NULL, NULL,4,3),
(3, 'lala', 'Psr. Samanhudi No. 529, Tegal 23678, Sulbar', 'minima', '7', '2023-04-01 16:24:32', '2023-04-07 03:37:39', 'dikembalikan', '1', 'Tempora id aut quod molestiae molestias numquam. Voluptatum dicta non doloribus id aspernatur. Non tempora non et fugiat. Labore eum molestiae deleniti est quasi quisquam laudantium.', NULL, NULL,1,1),
(4, 'dipsi', 'Gg. Samanhudi No. 102, Tidore Kepulauan 73050, Sulbar', 'enim', '10', '2023-04-29 03:04:20', '2023-05-21 04:37:55', 'dikembalikan', '1', 'Facere eaque expedita sit delectus deleniti libero sunt. Quasi eveniet id sed rem quaerat voluptas. Dicta in sapiente et deserunt ut. Accusantium placeat officia ut.', NULL, NULL,1,2),
(5, 'upin', 'Jln. Bappenas No. 981, Cimahi 23176, Maluku', 'commodi', '6', '2023-04-27 03:10:51', '2023-05-29 20:39:45', 'dipinjam', '1', 'Aut id aperiam qui in. Libero consectetur tenetur consequatur. Asperiores aut enim rerum nihil. Et iure est omnis autem itaque ut possimus.', NULL, NULL,2,5),
(6, 'ipin', 'Jr. Jend. A. Yani No. 799, Probolinggo 16013, Kepri', 'amet', '2', '2023-04-30 01:14:23', '2023-05-08 17:03:18', 'dipinjam', '0', 'Nemo aspernatur maxime animi deleniti voluptas omnis ullam optio. Eum autem quae corrupti sit sapiente recusandae. Impedit voluptates tempora illum.',NULL, NULL,3,10),
(7, 'Doraemon', 'Ki. Suryo No. 269, Sungai Penuh 54692, Sumbar', 'autem', '2', '2023-04-17 19:33:12', '2023-05-05 17:45:32', 'dikembalikan', '1', 'Dolor beatae ea a nostrum. Labore consequuntur consequatur ut tempora officia rerum. Libero vero nam deserunt saepe. Magnam qui omnis quo architecto autem. Vel laudantium ipsam beatae ut dolorum eaque.', NULL, NULL,8,3),
(8, 'novita', 'Ds. Bank Dagang Negara No. 140, Parepare 66094, Papua', 'perferendis', '10', '2023-04-04 08:28:15', '2023-05-12 06:10:25', 'dikembalikan', '1', 'Hic labore id blanditiis magni ipsa. Ratione aut enim voluptas voluptas quasi magnam. Earum fugiat placeat et tenetur ut.', NULL, NULL,9,5),
(9, 'Sakura', 'Ds. Imam Bonjol No. 191, Padang 19894, Sulsel', 'quos', '1', '2023-04-22 07:03:10', '2023-05-23 01:36:58', 'dikembalikan', '0', 'Minus et vel placeat velit debitis numquam. Harum placeat possimus ipsam reprehenderit perferendis sit.', NULL, NULL,9,1),
(10, 'Boboy', 'Psr. Laswi No. 661, Bau-Bau 41814, Banten', 'saepe', '8', '2023-04-19 02:21:09', '2023-05-27 13:41:45', 'dikembalikan', '0', 'Excepturi a eum odio officiis distinctio. Eligendi quia architecto quibusdam est aut. Quas qui maiores omnis aut asperiores. Nisi ea sed voluptatem dolorem.', NULL, NULL,10,7),
(11, 'Dora', 'Jr. Merdeka No. 488, Prabumulih 15494, Lampung', 'velit', '10', '2023-04-19 17:01:00', '2023-05-18 19:58:10', 'dipinjam', '1', 'Et dicta et modi rerum numquam ut ipsum. Inventore consequatur beatae voluptatem non quisquam enim. Sint ipsum vitae maiores quos ullam.',NULL, NULL,4,10),
(12, 'Spongebob', 'Ds. Pelajar Pejuang 45 No. 408, Ambon 18498, Gorontalo', 'rerum', '7', '2023-04-24 06:11:40', '2023-05-30 19:18:22', 'dikembalikan', '1', 'Ducimus quas vel quaerat perferendis. Minima veritatis est pariatur alias ex. Nostrum est neque ut omnis et.',NULL, NULL,8,7),
(13, 'Squidward', 'Psr. Padang No. 321, Banjarmasin 19327, Kalteng', 'esse', '10', '2023-04-13 04:01:14', '2023-05-24 19:46:49', 'dipinjam', '0', 'Ratione voluptas animi architecto. Harum et velit quisquam vitae. Qui saepe esse voluptas consequatur facilis.',NULL, NULL,1,5),
(14, 'Patrick', 'Jr. Flora No. 296, Pekalongan 28939, Bengkulu', 'sapiente', '3', '2023-04-06 11:01:31', '2023-06-03 00:25:34', 'dipinjam', '1', 'Placeat tenetur eos omnis officiis qui ut et pariatur. Odio optio blanditiis quis veritatis est quas esse. Quo aut non aliquam autem inventore.', NULL, NULL,3,7),
(15, 'Larva', 'Jr. Tubagus Ismail No. 149, Prabumulih 63500, Jatim', 'praesentium', '1', '2023-04-23 08:47:02', '2023-05-24 08:25:23', 'dikembalikan', '0', 'Aut ipsum ut corrupti doloribus impedit. Ut quibusdam autem ullam nisi velit velit dolorem. Fuga facilis sed magnam sit non ipsam dignissimos. Qui molestiae rerum provident dolore dolor minima.', NULL, NULL,3,7),
(16, 'Barbie', 'Ds. Baabur Royan No. 926, Sungai Penuh 72385, Kalteng', 'ut', '6', '2023-04-15 03:04:59', '2023-05-25 19:06:10', 'dikembalikan', '0', 'Voluptatem laboriosam rem ad enim beatae quia. Quia quam nam non alias nihil et veniam. Exercitationem vero fuga et ut dolor nisi.', NULL, NULL,10,7),
(17, 'dsjhweug', 'Jln. Aceh No. 381, Pariaman 93959, Jateng', 'veritatis', '6', '2023-04-29 19:26:09', '2023-05-12 09:30:59', 'dipinjam', '0', 'Excepturi sit ad alias nemo. Quasi omnis consequatur est ea et. Reprehenderit ipsum aut ducimus quibusdam.', NULL, NULL,4,10),
(18, 'LOO', 'Ds. Basuki Rahmat  No. 603, Mataram 83210, Jateng', 'ea', '3', '2023-04-23 11:48:28', '2023-05-16 17:22:05', 'dikembalikan', '0', 'Laboriosam rerum laboriosam necessitatibus quia. Ea aut est rem molestiae distinctio eaque. Eligendi provident ut doloremque voluptate molestiae rerum. Dolorem voluptatem ut ea et nulla consequatur.', NULL, NULL,6,7),
(19, 'Ehallo', 'Ds. Nanas No. 514, Lubuklinggau 53386, Kalsel', 'odit', '8', '2023-04-23 18:52:52', '2023-05-25 09:30:26', 'dipinjam', '0', 'Velit perspiciatis quam voluptatem quia velit. Similique omnis et omnis qui quas consequatur vel. Perspiciatis consequatur ab doloribus delectus consequatur velit eum ut.', NULL, NULL,7,7),
(20, 'Soopi', 'Dk. Peta No. 286, Malang 43388, Aceh', 'illum', '6', '2023-04-11 00:11:54', '2023-05-21 07:10:35', 'dikembalikan', '1', 'Quam temporibus et ut labore. Qui voluptatibus nesciunt nihil quam dolorem culpa voluptatem repellat. Inventore nam atque delectus autem.', NULL, NULL,1,2);

SELECT *FROM peminjaman;


-- data dummy tabel petani_edukasi --
INSERT INTO `petani_edukasi` (`petani_id`, `edukasi_id`) VALUES
('1', '2'),
('12', '3'),
('13', '3'),
('8', '2'),
('10', '4'),
('6', '5'),
('7', '4'),
('8', '3'),
('9', '3'),
('1', '5'),
('1', '7');
SELECT *FROM petani_edukasi;


-- data dummy tabel petani_barang --
INSERT INTO `petani_barang` (`petani_id`, `barang_id`) VALUES
('1', '3'),
('9', '10'),
('2', '3'),
('6', '4'),
('6', '8'),
('3', '1'),
('2', '7'),
('8', '3'),
('1', '2'),
('1', '1');
SELECT *FROM petani_barang;


-- data dummy tabel petani_proyek --
INSERT INTO `petani_proyek` (`petani_id`, `proyek_id`) VALUES
('1', '2'),
('2', '3'),
('4', '5'),
('2', '6'),
('3', '9'),
('2', '10'),
('1', '5'),
('4', '3'),
('2', '4'),
('2', '1');
SELECT *FROM petani_proyek;



-- 4.(b) Buat 10 query untuk menampilkan data dari 1 tabel

-- 1. Menampilkan semua kolom dan semua baris dari tabel "barang".
   SELECT * FROM barang;

/* 2.Menampilkan hanya kolom "nama" dan "jumlah" dari tabel "barang", 
   mengembalikan semua baris. */
   SELECT nama, jumlah FROM barang;

/* 3. Memilih kolom "id" dan "nama" dari tabel "barang", tetapi hanya untuk 
   baris-baris di mana kolom "jumlah" memiliki nilai '10'. */
   SELECT id,nama FROM barang WHERE jumlah='10';

/* 4. Memilih nilai unik dari kolom "jumlah" dalam tabel "barang". 
   Menghilangkan nilai duplikat dan mengembalikan daftar nilai yang berbeda.*/
   SELECT DISTINCT jumlah FROM barang;

/* 5. Memilih semua kolom dan semua baris dari tabel "barang", tetapi 
   hanya untuk baris-baris di mana kolom "jumlah" memiliki nilai yang lebih besar dari atau sama dengan 10. */
   SELECT * FROM barang WHERE jumlah >= 10;

/* 6. Memilih semua kolom dan semua baris dari tabel "barang", 
   mengurutkan hasilnya berdasarkan kolom "nama" secara menaik (urutan abjad). */
   SELECT * FROM barang ORDER BY nama ASC;

/* 7. Memilih semua kolom dan semua baris dari tabel "barang", 
   tetapi hanya untuk baris-baris di mana kolom "jumlah" memiliki nilai 
   antara 8 dan 20 (termasuk kedua nilai tersebut). */
   SELECT * FROM barang WHERE jumlah BETWEEN 8 AND 20;

/* 8. Memilih semua kolom dan semua baris dari tabel "barang", 
   tetapi hanya untuk baris-baris di mana kolom "nama" diawali dengan huruf 'a'. */
   SELECT * FROM barang WHERE nama LIKE 'a%';

/* 9. Memilih semua kolom dan semua baris dari tabel "barang", 
   tetapi hanya untuk baris-baris di mana kolom "nama" memiliki 
   nilai 'cangkul' dan kolom "jumlah" memiliki nilai 10. */
   SELECT * FROM barang WHERE nama ='cangkul' AND jumlah=10;

/* 10. Menghitung jumlah total kolom "jumlah" dalam tabel "barang" 
   dan mengembalikannya sebagai satu hasil dengan alias kolom "total_barang". */
   SELECT SUM(jumlah) AS total_barang FROM barang; 



/* 4.(c) membuat 10 QUERY untuk menampilkan DATA dari beberapa
	 tabel yang mencakup inner JOIN,left/right JOIN) 
*/ 

 /* 1. Query ini mengambil ID Peminjaman, Nama Peminjaman, dan Nama Petani 
    dari tabel "peminjaman" dan "petani" menggunakan operasi INNER JOIN.*/
    SELECT peminjaman.id AS `ID Peminjaman`, peminjaman.nama AS `Nama Peminjaman`, petani.nama AS `Nama Petani`
    FROM peminjaman
    INNER JOIN petani ON peminjaman.petani_id = petani.id;

/* 2. Query ini mengambil ID barang, Nama admin, Jumlah Barang, dan Total 
   Jumlah Barang dari tabel "barang" dan "admin" menggunakan operasi INNER JOIN. 
   Hasilnya dikelompokkan berdasarkan ID barang dan Nama admin.*/
   SELECT barang.id, admin.nama, COUNT(barang.id) AS `Jumlah Barang`, SUM(barang.jumlah) AS `Total Jumlah Barang`
   FROM barang
   INNER JOIN admin ON barang.admin_id = admin.id
   GROUP BY barang.id, admin.nama;

/* 3. Query ini mengambil ID edukasi, Judul edukasi, dan Nama admin dari 
   tabel "edukasi" dan "admin" menggunakan operasi INNER JOIN. Hanya baris 
   dengan Judul edukasi yang tidak NULL yang diambil, dan hasilnya diurutkan berdasarkan ID edukasi.*/
   SELECT edukasi.id, edukasi.judul, admin.nama
   FROM edukasi
   INNER JOIN admin ON edukasi.admin_id = admin.id
   WHERE edukasi.judul IS NOT NULL
   ORDER BY edukasi.id;

/* 4. Query ini mengambil ID Peminjaman, Nama Peminjaman, dan Nama Petani dari 
   tabel "peminjaman" dan "petani" menggunakan operasi LEFT JOIN. Semua baris 
   dari tabel "peminjaman" diambil, dan hanya baris yang memiliki kecocokan dari 
   tabel "petani" yang diambil. Baris dengan Nama Peminjaman yang tidak NULL yang diambil.*/
   SELECT peminjaman.id AS `ID Peminjaman`, peminjaman.nama AS `Nama Peminjaman`, petani.nama AS `Nama Petani`
   FROM peminjaman
   LEFT JOIN petani ON peminjaman.petani_id = petani.id
   WHERE peminjaman.nama IS NOT NULL;

/* 5. Query ini mengambil ID barang, Nama admin, dan Jumlah Barang dari tabel 
   "barang" dan "admin" menggunakan operasi LEFT JOIN. Hasilnya dikelompokkan 
   berdasarkan ID barang dan Nama admin.*/
   SELECT barang.id, admin.nama, COUNT(barang.id) AS `ID Barang`
   FROM barang
   LEFT JOIN admin ON barang.admin_id = admin.id
   GROUP BY barang.id, admin.nama;

/* 6. Query ini mengambil ID edukasi, Judul edukasi, dan Nama admin dari tabel "edukasi" dan "admin" 
  menggunakan operasi LEFT JOIN. Semua baris dari tabel "edukasi" diambil, dan hanya baris yang 
  memiliki kecocokan dari tabel "admin" yang diambil. Hasilnya diurutkan berdasarkan ID edukasi.*/
  SELECT edukasi.id, edukasi.judul, admin.nama
  FROM edukasi
  LEFT JOIN admin ON edukasi.admin_id = admin.id
  ORDER BY edukasi.id;

/* 7. Query ini mengambil ID Peminjaman, Nama Peminjaman, dan Nama Petani dari tabel 
   "peminjaman" dan "petani" menggunakan operasi RIGHT JOIN. Semua baris dari tabel 
   "petani" diambil, dan hanya baris yang memiliki kecocokan dari tabel "peminjaman" yang diambil.*/
   
    SELECT peminjaman.id AS `ID Peminjaman`, peminjaman.nama AS `Nama Peminjaman`, petani.nama AS `Nama Petani`
    FROM peminjaman
    RIGHT JOIN petani ON peminjaman.petani_id = petani.id;

/* 8. Query ini mengambil ID barang, Nama admin, dan Jumlah Barang dari tabel 
   "barang" dan "admin" menggunakan operasi RIGHT JOIN. Hasilnya dikelompokkan 
   berdasarkan ID barang dan Nama admin.*/
   
   SELECT barang.id, admin.nama, SUM(barang.id) AS `ID Barang`
   FROM barang
   RIGHT JOIN admin ON barang.admin_id = admin.id
   GROUP BY barang.id, admin.nama;

/* 9. Query ini mengambil ID edukasi, Judul edukasi, dan Nama admin dari 
   tabel "edukasi" dan "admin" menggunakan operasi RIGHT JOIN. Semua baris 
   dari tabel "admin" diambil, dan hanya baris yang memiliki kecocokan dari 
   tabel "edukasi" dan Judul edukasi yang tidak NULL yang diambil. 
   Hasilnya diurutkan berdasarkan ID edukasi.*/
   
   SELECT edukasi.id, edukasi.judul, admin.nama
   FROM edukasi
   RIGHT JOIN admin ON edukasi.admin_id = admin.id
   WHERE edukasi.judul IS NOT NULL
   ORDER BY edukasi.id;

/* 10. Query ini menggabungkan hasil dari dua query menggunakan UNION. 
   Query pertama mengambil ID edukasi, Judul edukasi, dan Nama admin dari 
   tabel "edukasi" dan "admin" menggunakan operasi LEFT JOIN. 
   Query kedua juga mengambil kolom yang sama tetapi menggunakan operasi 
   RIGHT JOIN. Baris yang memiliki edukasi.id NULL juga diambil, yang 
   sebenarnya mengambil baris yang tidak memiliki kecocokan*/
   
   SELECT edukasi.id, edukasi.judul, admin.nama
   FROM edukasi
   LEFT JOIN admin ON edukasi.admin_id = admin.id
   UNION
   SELECT edukasi.id, edukasi.judul, admin.nama
   FROM edukasi
   RIGHT JOIN admin ON edukasi.admin_id = admin.id
   WHERE edukasi.id IS NULL;



-- 4.(d) Buat 5 penggunaan subquery

--  1. Menggunakan subquery dalam klausa SELECT:
SELECT id, nama, alamat, (SELECT COUNT(*) FROM edukasi) AS total_edukasi
FROM petani;

--  2. Menggunakan subquery dalam klausa WHERE:
SELECT id, nama, alamat
FROM petani
WHERE id IN (SELECT admin_id FROM edukasi);

--  3. Menggunakan subquery dalam klausa FROM:
SELECT p.id, p.nama, e.jumlah_edukasi
FROM (SELECT COUNT(*) AS jumlah_edukasi, admin_id FROM edukasi GROUP BY admin_id) AS e
JOIN petani AS p ON p.id = e.admin_id;

-- 4. Subquery untuk mengambil data petani yang belum pernah membuat edukasi:
SELECT * FROM petani WHERE id NOT IN (SELECT DISTINCT admin_id FROM edukasi);

-- 5. Subquery untuk mengambil data petani dengan jumlah edukasi terbanyak:
SELECT * FROM petani WHERE id = (SELECT admin_id FROM edukasi GROUP BY admin_id ORDER BY COUNT(*) DESC LIMIT 1);

