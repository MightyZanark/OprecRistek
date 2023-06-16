# Tugas Khusus Mobile Development RISTEK 2023

Aplikasi ini akan menampilkan list anime yang sedang airing sekarang dari urutan paling pertama berdasarkan [API MyAnimeList](https://myanimelist.net/apiconfig/references/api/v2).
Saat gambar salah satu anime di pencet, akan muncul detail page yang berisikan `gambar anime` itu lagi, `judul` langsung dari MyAnimeList, `judul alternative` dalam Bahasa Inggris dan Jepang jika ada, `Score` anime tersebut yang berasal dari rating user, `Rank` yang merupakan peringkat anime tersebut secara keseluruhan, `Synopsis` dari anime tersebut, `Genre` anime, dan juga `Studio` yang bersangkutan.

Selain detail anime, ada juga `Profile Page` yang berisikan data diri saya. `Profile Page` ini bisa dicapai melalui tombol garis 3 yang berada di pojok kanan atas aplikasi.

## Package Used

Selain dari package standard dari `Flutter` dan `dart`, package lain yang saya gunakan adalah:
- [http](https://pub.dev/packages/http)
