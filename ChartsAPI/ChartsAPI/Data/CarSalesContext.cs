using ChartsAPI.Models;
using Microsoft.EntityFrameworkCore;

public class CarSalesContext : DbContext
{
    public CarSalesContext(DbContextOptions<CarSalesContext> options)
        : base(options)
    {
    }

    public DbSet<CarSalesReport> CarSalesReports { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // View için model konfigürasyonu
        modelBuilder.Entity<CarSalesReport>()
            .HasNoKey() // Birincil anahtar tanımlanmadığını belirtir
            .ToView("BrandSalesReport"); // Veritabanındaki VIEW'in adı
    }
}
