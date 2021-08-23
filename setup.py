from glob import glob
import setuptools

setuptools.setup(
    name='animation_cache',
    packages=setuptools.find_packages(),
    package_data={
        'animation_cache': [
            '*.ui', 'tests/resources/*.ma', 'tests/resources/*.abc',
        ],
    },
    include_package_data=True,
    install_requires=[],
)
