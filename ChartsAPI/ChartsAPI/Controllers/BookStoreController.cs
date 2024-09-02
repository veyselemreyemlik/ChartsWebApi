using Microsoft.AspNetCore.Mvc;
using ChartsAPI.Models;
using System.Linq;
using System.Security.Cryptography.X509Certificates;

[Route("api/[controller]")]
[ApiController]
public class BookStoreController : ControllerBase
{
    private readonly BookStoreContext _context;

    public BookStoreController(BookStoreContext context)
    {
        _context = context;
    }

    [HttpGet]
    public IActionResult GetAuthorSales()
    {
        var authorSales = _context.AuthorSalesReports.ToList(); // DbSet adı güncellendi
        return Ok(authorSales);
    }
}
