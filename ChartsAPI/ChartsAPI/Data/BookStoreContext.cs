using Microsoft.EntityFrameworkCore;
using ChartsAPI.Models;

public class BookStoreContext : DbContext
{
    public BookStoreContext(DbContextOptions<BookStoreContext> options)
        : base(options)
    {
    }

    public DbSet<AuthorSalesReport> AuthorSalesReports { get; set; } // DbSet adını çoğul hale getirdik

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // View için model konfigürasyonu
        modelBuilder.Entity<AuthorSalesReport>()
            .HasNoKey() // Birincil anahtar tanımlanmadığını belirtir
            .ToView("AuthorSalesReport"); // Veritabanındaki VIEW'in adı
    }
}
