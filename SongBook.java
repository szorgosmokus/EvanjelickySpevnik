import java.util.List;

public class SongBook {
    public String title;
    public List<Chapter> chapters;

    SongTitles songTitles = new SongTitles();

    public SongBook() {
        this.title = "Evanjelický spevník";
        chapters.add(1, new Chapter("Spevník"));
        chapters.get(1).Songs.clear();
        for (int i = 1; i < songTitles.piesne.size(); i++) {

        }

        chapters.add(new Chapter("Antifóny"));
        chapters.add(new Chapter("Pašie"));
        chapters.add(new Chapter("Funebrál"));
        chapters.add(new Chapter("Predspevy"));
        chapters.add(new Chapter("Pohrebné antifóny"));
        chapters.add(new Chapter("Večera Pánova"));
        chapters.add(new Chapter("Ďalšia liturgia"));
        chapters.add(new Chapter("Informácie"));
    }
}

class Chapter {
    String title;
    List<Song> Songs;

    public Chapter(String title){
        this.title = title;
    }
}

class Song {
    String chapter;
    String title;
    String text;
    String path;
}
