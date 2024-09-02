using Microsoft.AspNetCore.Mvc;
using System.Linq;

[Route("api/[controller]")]
[ApiController]
public class CarSalesController : ControllerBase
{
    private readonly CarSalesContext _context;

    public CarSalesController(CarSalesContext context)
    {
        _context = context;
    }

    [HttpGet]
    public IActionResult GetCarSalesReports()
    {
        var carSalesReports = _context.CarSalesReports.ToList();
        return Ok(carSalesReports);
    }
}
