using ChartsAPI.Models;
using Microsoft.EntityFrameworkCore;

public class MovieStoreContext : DbContext
{
    public MovieStoreContext(DbContextOptions<MovieStoreContext> options)
        : base(options)
    {
    }

    public DbSet<DirectorViewReport> DirectorViewReports { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // View için model konfigürasyonu
        modelBuilder.Entity<DirectorViewReport>()
            .HasNoKey() // Birincil anahtar tanımlanmadığını belirtir
            .ToView("DirectorViewReport"); // Veritabanındaki VIEW'in adı
    }
}
