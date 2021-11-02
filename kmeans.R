#Bagian Data Preparation
pelanggan <- read.csv("customer_segments.txt", sep="\t")
pelanggan_matrix <- data.matrix(pelanggan[c("Jenis.Kelamin", "Profesi", "Tipe.Residen")])
pelanggan <- data.frame(pelanggan, pelanggan_matrix)
Profesi <- unique(pelanggan[c("Profesi","Profesi.1")])
Jenis.Kelamin <- unique(pelanggan[c("Jenis.Kelamin","Jenis.Kelamin.1")])
Tipe.Profesi <- unique(pelanggan[c("Tipe.Residen","Tipe.Residen.1")])
pelanggan$NilaiBelanjaSetahun <- pelanggan$NilaiBelanjaSetahun/1000000
field_yang_digunakan = c("Jenis.Kelamin.1", "Umur", "Profesi.1", "Tipe.Residen.1","NilaiBelanjaSetahun")
#Bagian K-Means
set.seed(100)
#fungsi kmeans untuk membentuk 5 cluster dengan 25 skenario random dan simpan ke dalam variable segmentasi
segmentasi <- kmeans(x=pelanggan[field_yang_digunakan], centers=5, nstart=25)
#tampilkan hasil k-means
segmentasi

# Melihat clustering vector
segmentasi$cluster

# Masukan hasil clustering ke data awal
pelanggan$cluster <- segmentasi$cluster

# Tampilkan struktur cluster
str(pelanggan)

#Analisa hasil
#Filter cluster ke-1, indeks ke berapa saja yang merupakan cluster 1
which(pelanggan$cluster == 1)

# itung ada berapa data yang berada di cluster 2
length(which(pelanggan$cluster == 2))

#Analisa hasil, misal kita ingin melihat isi data yang berada di cluster 1
#Melihat data cluster ke 1
pelanggan[which(pelanggan$cluster == 1),]

#Melihat cluster means dari objek 
# Cluster means adalah hasil nilai rata-rata atau titik sentral (centroid) dari seluruh titik tiap cluster.
segmentasi$centers

#Membandingkan dengan 2 cluster kmeans, masing-masing 2 dan 5
set.seed(100)
kmeans(x=pelanggan[field_yang_digunakan], centers=2, nstart=25)
set.seed(100)
kmeans(x=pelanggan[field_yang_digunakan], centers=5, nstart=25)

# Melihat komponen lain seperti withinss untuk penjelasan nya silahkan baca dokumentasi
segmentasi$withinss
segmentasi$cluster
segmentasi$tot.withinss